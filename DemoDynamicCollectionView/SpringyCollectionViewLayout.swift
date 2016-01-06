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
    
    var latestDelta : CGFloat = 0
    
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
        
        let visibleRect = CGRectInset(CGRect(origin: collectionView!.bounds.origin, size: collectionView!.bounds.size), -100, -100)
        let attributesInVisibleRect = super.layoutAttributesForElementsInRect(visibleRect)!
        
        var indexPathsInVisibleRect : Set<NSIndexPath> = Set()
        
        for layoutAttribute in attributesInVisibleRect {
            indexPathsInVisibleRect.insert(layoutAttribute.indexPath)
        }
        
        let noLongerVisibleBehaviors = dynamicAnimator.behaviors.filter { (behavior) -> Bool in
            if let attachBehavior = behavior as? UIAttachmentBehavior {
                return !indexPathsInVisibleRect.contains((attachBehavior.items.first as! UICollectionViewLayoutAttributes).indexPath)
            }
            else{
                return false
            }
        }
        
        for behavior in noLongerVisibleBehaviors {
            dynamicAnimator.removeBehavior(behavior)
            visibleIndexPathsSet.remove(((behavior as! UIAttachmentBehavior).items.first as! UICollectionViewLayoutAttributes).indexPath)
        }
        
        let newlyVisibleItems = attributesInVisibleRect.filter({ (item) in
            return !visibleIndexPathsSet.contains(item.indexPath)
        })
        
        let touchLocation = collectionView!.panGestureRecognizer.locationInView(collectionView)
        
        for layoutAttribute in newlyVisibleItems {
            var center = layoutAttribute.center
            let springyBehavior = UIAttachmentBehavior(item: layoutAttribute, attachedToAnchor: center)
            
            springyBehavior.length = 0
            springyBehavior.damping = 0.8
            springyBehavior.frequency = 1.0
            
            if !CGPointEqualToPoint(CGPointZero, touchLocation) {
                let yDist = fabsf(Float(touchLocation.y - springyBehavior.anchorPoint.y))
                let xDist = fabsf(Float(touchLocation.x - springyBehavior.anchorPoint.x))
                let resistance = CGFloat((yDist + xDist) / 1500)
                
                if (latestDelta < 0) {
                    center.y += max(latestDelta, latestDelta * resistance)
                }
                else{
                    center.y += min(latestDelta, latestDelta * resistance)
                }
                
                layoutAttribute.center = center
                
                dynamicAnimator.addBehavior(springyBehavior)
                visibleIndexPathsSet.insert(layoutAttribute.indexPath)
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
        
        latestDelta = delta
        
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
    
    func resetLayout() {
        dynamicAnimator.removeAllBehaviors()
        prepareLayout()
    }
}
