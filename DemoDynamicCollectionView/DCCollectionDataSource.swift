//
//  DCCollectionDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 5/24/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class DCCollectionDataSource: NSObject, UICollectionViewDataSource {
    
    var numberOfItems : Int
    var color : UIColor
    
    init(color : UIColor, numberOfItems: Int) {
        self.color = color
        self.numberOfItems = numberOfItems
        
        super.init()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ColorCell", forIndexPath: indexPath)
        cell.backgroundColor = color
        
        let label : UILabel? = cell.viewWithTag(2) as? UILabel
        
        label?.text = "\(indexPath.section) - \(indexPath.row)"
        
        cell.layer.borderColor = UIColor.yellowColor().CGColor
        cell.layer.borderWidth = 1
        
        print("color cell size : \(cell.bounds.size)")
        
        return cell
    }
}
