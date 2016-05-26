//
//  DCFlowLayoutWithAnimations.swift
//  DemoCollectionView
//
//  Created by Wizard Li on 5/25/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class DCFlowLayoutWithAnimations : UICollectionViewFlowLayout {
    private var previousSize = CGSizeZero
    private var indexPathsToAnimate = [NSIndexPath]()
    
    private var pinchedItem : NSIndexPath?
    private var pinchedItemSize = CGSizeZero
    
    func resizeItemAtIndexPath(indexPath : NSIndexPath, withPinchDistance distance:CGFloat) {
        pinchedItem = indexPath
        pinchedItemSize = CGSize(width: distance, height: distance)
    }
    
    func resetPinchedItem() {
        pinchedItem = nil
        pinchedItemSize = CGSizeZero
    }
    
    func commonInit() {
        self.itemSize = CGSizeMake(50, 50)
        self.minimumLineSpacing = 16
        self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8)
    }
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attrs = super.layoutAttributesForElementsInRect(rect)
        if let pinchedItem = pinchedItem {
            let attr = attrs?.filter({ (attribute) -> Bool in
                return attribute.indexPath == pinchedItem
            }).first
            
            if let attribute = attr {
                attribute.size = pinchedItemSize
                attribute.zIndex = 100
            }
        }
        
        return attrs
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attr = super.layoutAttributesForItemAtIndexPath(indexPath)
        
        if let attribute = attr where attribute.indexPath == pinchedItem {
            attribute.size = pinchedItemSize
            attribute.zIndex = 100
        }
        
        return attr
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attr = layoutAttributesForItemAtIndexPath(itemIndexPath),
            let collectionView = collectionView
            else { return nil }
        
        if let index = indexPathsToAnimate.indexOf(itemIndexPath) {
            attr.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(0.2, 0.2), CGFloat(M_PI))
            attr.center = CGPoint(x: CGRectGetMidX(collectionView.bounds), y: CGRectGetMaxY(collectionView.bounds))
            
            indexPathsToAnimate.removeAtIndex(index)
        }
        
        return attr
    }
    
    override func finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attr = super.finalLayoutAttributesForDisappearingItemAtIndexPath(itemIndexPath),
            let collectionView = collectionView
            else { return nil }
        
        if let index = indexPathsToAnimate.indexOf(itemIndexPath) {
            
            var flyUpTransform = CATransform3DIdentity
            flyUpTransform.m34 = 1.0 / -20000
            flyUpTransform = CATransform3DTranslate(flyUpTransform, 0, 0, 19500)
            attr.transform3D = flyUpTransform
            attr.center = collectionView.center
            
            attr.alpha = 0.2
            attr.zIndex = 1
            
            indexPathsToAnimate.removeAtIndex(index)
        }
        else {
            attr.alpha = 1.0
        }
        
        return attr
    }
    
    override func prepareLayout() {
        super.prepareLayout()
        
        guard let collectionView = collectionView else { return }
        previousSize = collectionView.bounds.size
    }
    
    override func prepareForCollectionViewUpdates(updateItems: [UICollectionViewUpdateItem]) {
        super.prepareForCollectionViewUpdates(updateItems)
        
        var indexPaths = [NSIndexPath]()
        
        for updateItem in updateItems {
            switch updateItem.updateAction {
            case .Insert:
                if let indexPath = updateItem.indexPathAfterUpdate {
                    indexPaths.append(indexPath)
                }
            case .Delete:
                if let indexPath = updateItem.indexPathBeforeUpdate {
                    indexPaths.append(indexPath)
                }
            case .Move:
                if let indexPath1 = updateItem.indexPathBeforeUpdate,
                    let indexPath2 = updateItem.indexPathAfterUpdate {
                    indexPaths.append(indexPath1)
                    indexPaths.append(indexPath2)
                }
            default:
                break
            }
        }
        
        indexPathsToAnimate = indexPaths
    }
    
    override func finalizeCollectionViewUpdates() {
        super.finalizeCollectionViewUpdates()
        
        indexPathsToAnimate.removeAll()
    }
    
    override func prepareForAnimatedBoundsChange(oldBounds: CGRect) {
        super.prepareForAnimatedBoundsChange(oldBounds)
    }
    
    override func finalizeAnimatedBoundsChange() {
        super.finalizeAnimatedBoundsChange()
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        if let collectionView = collectionView {
            let oldBounds = collectionView.bounds
            return oldBounds.size != newBounds.size
        }
        
        return false
    }
}











































