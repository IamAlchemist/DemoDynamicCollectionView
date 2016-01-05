//
//  SpringyCollectionViewLayout.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/5/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class SpringyCollectionViewLayout : UICollectionViewFlowLayout {
    
    lazy var dynamicAnimator : UIDynamicAnimator = { [unowned self] in
        return UIDynamicAnimator(collectionViewLayout: self)
    }()
    
    var visibleIndexPathsSet : Set<NSIndexPath> = []
    
    override init() {
        super.init()
        
        initialize()
    }
    
    func initialize() {
        minimumInteritemSpacing = 10
        minimumLineSpacing = 10
        itemSize = CGSizeMake(44, 44)
        sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let contentSize = (collectionView?.contentSize)!
        let items = super.layoutAttributesForElementsInRect(CGRect(x: 0, y: 0, width: contentSize.width, height: contentSize.height))!
        
        if (dynamicAnimator.behaviors.count == 0) {
            for item in items {
                let behavior = UIAttachmentBehavior(item: item, attachedToAnchor: item.center)
                behavior.length = 0
                behavior.damping = 0.8
                behavior.frequency = 1
                
                dynamicAnimator.addBehavior(behavior)
            }
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return dynamicAnimator.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        let scrollView = collectionView! as UIScrollView
        let delta = newBounds.origin.y - scrollView.bounds.origin.y
        
        let touchLocation = (collectionView?.panGestureRecognizer.locationInView(collectionView))!
        
        for behavior in dynamicAnimator.behaviors as! [UIAttachmentBehavior] {
            let yDistance = fabsf(Float(touchLocation.y - behavior.anchorPoint.y))
            let xDistance = fabsf(Float(touchLocation.x - behavior.anchorPoint.x))
            let scrollResistance = CGFloat((yDistance + xDistance)/1500)
            
            let item = behavior.items.first!
            var center = item.center
            if delta < 0 {
                center.y += max(delta, delta * scrollResistance)
            }
            else{
                center.y += min(delta, delta * scrollResistance)
            }
            
            item.center = center
            
            dynamicAnimator.updateItemUsingCurrentState(item)
        }
        
        return false
    }
}