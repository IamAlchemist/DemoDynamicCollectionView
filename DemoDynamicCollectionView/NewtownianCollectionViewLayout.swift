//
//  NewtownianCollectionViewLayout.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/6/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class NewtownianCollectionViewLayout : UICollectionViewFlowLayout {
    
    let kItemSize : CGFloat = 100
    
    lazy var dynamicAnimator : UIDynamicAnimator = { [unowned self] in
        let result = UIDynamicAnimator(collectionViewLayout: (self as UICollectionViewFlowLayout))
        result.addBehavior(self.gravityBehavior)
        result.addBehavior(self.collisionBehavior)
        return result
    }()
    
    lazy var gravityBehavior : UIGravityBehavior = {
        let behavior = UIGravityBehavior(items: [])
        behavior.gravityDirection = CGVector(dx: 0, dy: 1)
        return behavior
    }()
    
    lazy var collisionBehavior : UICollisionBehavior = {
        return UICollisionBehavior(items: [])
    }()
    
    func attachmentPoint() -> CGPoint {
        return CGPoint(x: CGRectGetMidX(collectionView!.bounds), y: 64)
    }
    
    override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
        super.prepareForCollectionViewUpdates(updateItems)
        
        for item in updateItems
        {
            if item.updateAction == .Insert
            {
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: item.indexPathAfterUpdate!)
                
                attributes.frame = CGRect(x: CGRectGetMaxX(collectionView!.frame) + kItemSize, y: 200, width: kItemSize, height: kItemSize)
                
                let attachmentBehavior = UIAttachmentBehavior(item: attributes, attachedToAnchor: attachmentPoint())
                attachmentBehavior.length = 200
                attachmentBehavior.damping = 0.4
                attachmentBehavior.frequency = 1.0
                
                dynamicAnimator.addBehavior(attachmentBehavior)
                gravityBehavior.addItem(attributes)
                collisionBehavior.addItem(attributes)
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.bounds.size
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return dynamicAnimator.itemsInRect(rect) as? [UICollectionViewLayoutAttributes]
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
    }
}
