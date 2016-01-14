//
//  PinterestViewLayout.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/13/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

protocol PinterestLayoutDelegate {
    func heightForPhotoAtIndexPath(indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
    func heightForAnnotationAtIndexPath(indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat
}

class PinterestViewLayout : UICollectionViewLayout {
    override class func layoutAttributesClass() -> AnyClass {
        return PinterestViewLayoutAttributes.self
    }
    
    var delegate : PinterestLayoutDelegate!
    
    var numberOfColumns = 2
    var cellPadding : CGFloat = 6.0
    
    private var cache = [NSIndexPath : PinterestViewLayoutAttributes]()
    
    private var contentWidth : CGFloat {
        let insets = collectionView!.contentInset
        return CGRectGetWidth(collectionView!.bounds) - insets.left - insets.right
    }
    
    private var contentHeight : CGFloat = 0.0
    
    override func prepareLayout() {
        super.prepareLayout()
        
        if cache.isEmpty {
            let columnWidth = contentWidth / CGFloat(numberOfColumns)
            
            var xOffset = [CGFloat]()
            for column in 0..<numberOfColumns {
                xOffset.append(CGFloat(column) * columnWidth)
            }
            
            var yOffset = [CGFloat](count: numberOfColumns, repeatedValue: 0)
            
            var column = 0
            
            for item in 0 ..< collectionView!.numberOfItemsInSection(0) {
                
                let indexPath = NSIndexPath(forItem: item, inSection: 0)
                
                let width = columnWidth - cellPadding * 2
                
                let photoHeight = delegate.heightForPhotoAtIndexPath(indexPath, withWidth: width)
                
                let annotationHeight = delegate.heightForAnnotationAtIndexPath(indexPath, withWidth: width)
                
                let height = cellPadding * 2 + photoHeight + annotationHeight
                
                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: height)
                let insetFrame = CGRectInset(frame, cellPadding, cellPadding)
                
                let attributes = PinterestViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.photoHeight = photoHeight
                attributes.frame = insetFrame
                
                cache[indexPath] = attributes
                
                contentHeight = max(contentHeight, CGRectGetMaxY(frame))
                yOffset[column] += height
                
                column = column == (numberOfColumns - 1) ? 0 : ++column
            }
        }
    }
    
    override func collectionViewContentSize() -> CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache.values {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath]
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
