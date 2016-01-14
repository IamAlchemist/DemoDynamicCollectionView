//
//  PinterestDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/14/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

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
