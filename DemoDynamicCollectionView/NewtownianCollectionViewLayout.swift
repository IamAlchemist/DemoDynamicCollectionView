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
    
    var attachmentBehaviors = [Int : UIAttachmentBehavior]()
    
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
    
    func idsFromDataSource() -> Set<Int> {
        var ids = Set<Int>()
        
        let datasource = collectionView!.dataSource as! NewtownianCollectionViewDataSource
        
        for id in datasource.data {
            ids.insert(id)
        }
        
        return ids
    }
    
    func idsFromAttachmentBehaviors() -> Set<Int> {
        return Set<Int>(attachmentBehaviors.keys)
    }
    
    func fixTheIndexPathForLayoutAttributes() {
        let dataSource = collectionView!.dataSource as! NewtownianCollectionViewDataSource
        for behavior in attachmentBehaviors.values {
            let attribute = behavior.items.first as! NewtownianLayoutAttributes
            let row = dataSource.data.indexOf(attribute.id)!
            attribute.indexPath = NSIndexPath(forItem: row, inSection: 0)
        }
    }
    
    func layoutAttributesInAttachmentBehaviorForId(id : Int) -> NewtownianLayoutAttributes? {
        let behavior = attachmentBehaviors[id]
        return behavior
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        let newlyVisibleIds = idsFromDataSource().subtract(idsFromAttachmentBehaviors())
        let nolongerVisibleIds = idsFromAttachmentBehaviors().subtract(idsFromDataSource())
        
        for id in nolongerVisibleIds {
            let behavior = attachmentBehaviors[id]!
            attachmentBehaviors[id] = nil
            
            let attributes = layoutAttributesInAttachmentBehaviorForId(id)!
            dynamicAnimator.removeBehavior(behavior)
            gravityBehavior.removeItem(attributes)
            collisionBehavior.removeItem(attributes)
        }
        
        for id in newlyVisibleIds {
            let attributes = NewtownianLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: id, inSection: 0))
            attributes.id = id
            attributes.frame = CGRect(x: CGRectGetMaxX(collectionView!.frame) + kItemSize, y: 200, width: kItemSize, height: kItemSize)
                
            let attachmentBehavior = UIAttachmentBehavior(item: attributes, attachedToAnchor: attachmentPoint())
            attachmentBehavior.length = 200
            attachmentBehavior.damping = 0.4
            attachmentBehavior.frequency = 1.0
            
            attachmentBehaviors[id] = attachmentBehavior
                
            dynamicAnimator.addBehavior(attachmentBehavior)
            gravityBehavior.addItem(attributes)
            collisionBehavior.addItem(attributes)
        }
        
        fixTheIndexPathForLayoutAttributes()
    }
    
    override func collectionViewContentSize() -> CGSize {
        return collectionView!.bounds.size
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return (dynamicAnimator.itemsInRect(rect) as! [UICollectionViewLayoutAttributes])
//        let dataSource = collectionView?.dataSource as! NewtownianCollectionViewDataSource
//        
//        var layoutAttributes = [UICollectionViewLayoutAttributes]()
//        
//        var string = "index paths : "
//        for attributes in (dynamicAnimator.itemsInRect(rect) as! [UICollectionViewLayoutAttributes]){
//            if dataSource.data.contains(attributes.indexPath.row) {
//                layoutAttributes.append(attributes)
//                string += "\(attributes.indexPath.row),"
//            }
//        }
//        
//        print(string)
//
//        return layoutAttributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return dynamicAnimator.layoutAttributesForCellAtIndexPath(indexPath)
    }
}
