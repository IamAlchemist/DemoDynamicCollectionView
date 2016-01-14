//
//  PinterestViewLayout.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/13/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
}

class PinterestViewLayout : UICollectionViewLayout {
    override class func layoutAttributesClass() -> AnyClass {
        return PinterestViewLayoutAttributes.self
    }
    
    var numberOfColumns = 2
    var cellPadding : CGFloat = 6.0
    
    private var cache = [PinterestViewLayoutAttributes]()
    
    private var contentWidth : CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - insets.left - insets.right
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        if cache.isEmpty {
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            
            var xOffset = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            
            var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                let width = columnWidth - cellPadding * 2
                
            }
        }
    }
}

class PinterestViewLayoutAttributes : UICollectionViewLayoutAttributes {
    var photoHeight : CGFloat = 0.0
    
    override func copyWithZone(zone: NSZone) -> AnyObject {
        let copy = super.copyWithZone(zone) as! PinterestViewLayoutAttributes
        copy.photoHeight = photoHeight
        return copy
    }
    
    override func isEqual(object: AnyObject?) -> Bool {
        if let attributes = object as? PinterestViewLayoutAttributes {
            if attributes.photoHeight == photoHeight {
                return super.isEqual(object)
            }
        }
        
        return false
    }
}
