//
//  DCLineToGridAnimator.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 5/25/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class DCLineToGridAnimator : NSObject {
    var fromCollectionView : UICollectionView
    
    init(fromCollectionView : UICollectionView) {
        self.fromCollectionView = fromCollectionView
        super.init()
    }
}

extension DCLineToGridAnimator : UIViewControllerAnimatedTransitioning {
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.6
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containerView = transitionContext.containerView(),
            let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? UICollectionViewController,
            let fromView = fromVC.view,
            let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? UICollectionViewController,
            let toView = toVC.view
            else { return }
        
        guard let initialRect = containerView.window?.convertRect(fromCollectionView.frame, fromView: fromCollectionView.superview)
            else { return }
        
        let finalRect = transitionContext.finalFrameForViewController(toVC)
        
        guard let toCollectionView = toVC.collectionView,
            let toLayout = toCollectionView.collectionViewLayout as? UICollectionViewFlowLayout,
            let currentLayout = fromCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            else { return }

        let currentLayoutCopy = UICollectionViewFlowLayout()
        currentLayoutCopy.itemSize = currentLayout.itemSize
        currentLayoutCopy.sectionInset = currentLayout.sectionInset
        currentLayoutCopy.minimumLineSpacing = currentLayout.minimumLineSpacing
        currentLayoutCopy.minimumInteritemSpacing = currentLayout.minimumInteritemSpacing
        currentLayoutCopy.scrollDirection = currentLayout.scrollDirection
        
        self.fromCollectionView.setCollectionViewLayout(currentLayoutCopy, animated: false)
        
        var contentInset = toCollectionView.contentInset
        print("to colletion view content inset : \(contentInset)")
        let oldBottomInset = contentInset.bottom
        contentInset.bottom = CGRectGetHeight(finalRect) - (toLayout.itemSize.height + toLayout.sectionInset.bottom + toLayout.sectionInset.top)
        print("to colletion view content inset changed : \(contentInset)")
        
        toCollectionView.contentInset = contentInset
        toCollectionView.setCollectionViewLayout(currentLayout, animated: false)
        toView.frame = initialRect
        containerView.insertSubview(toView, aboveSubview: fromView)
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext),
                                   delay: 0,
                                   options: UIViewAnimationOptions.BeginFromCurrentState,
                                   
                                   animations: {
                                    toView.frame = finalRect
                                    
                                    toCollectionView.performBatchUpdates({
                                        toCollectionView.setCollectionViewLayout(toLayout, animated: false)
                                        },
                                        completion: { _ in
                                            toCollectionView.contentInset = UIEdgeInsetsMake(contentInset.top,
                                                contentInset.left,
                                                oldBottomInset,
                                                contentInset.right)
                                        }
                                    )
                                   },
                                   
                                   completion: { _ in
                                    transitionContext.completeTransition(true)
                                   })
    }
}


