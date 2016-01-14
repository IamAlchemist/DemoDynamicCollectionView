//
//  PinterestDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/14/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit
import AVFoundation

class PinterestDataSource : NSObject, UICollectionViewDataSource {
    var photos = Photo.allPhotos()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PinterestCell", forIndexPath: indexPath) as! PinterestCell
        
        cell.configCell(photos[indexPath.item])
        
        return cell
    }
}

extension PinterestDataSource : PinterestLayoutDelegate {

    func heightForPhotoAtIndexPath(indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        
        let photo = photos[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRectWithAspectRatioInsideRect(photo.image.size, boundingRect)
        
        return rect.size.height
    }
    
    func heightForAnnotationAtIndexPath(indexPath: NSIndexPath, withWidth width: CGFloat) -> CGFloat {
        
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        
        let photo = photos[indexPath.item]
        let font = UIFont(name: "AvenirNext-Regular", size: 10)!
        let commentHeight = photo.heightForComment(font, width: width)
        let height = annotationPadding * 2 + annotationHeaderHeight + commentHeight
        
        return height
    }
}
