//
//  DCSimpleDetailViewController.swift
//  DemoCollectionView
//
//  Created by Wizard Li on 5/25/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

enum DCColor : Int {
    case Red = 0
    case Green = 1
    case Blue = 2
}

class DCSimpleDetailViewController : UICollectionViewController {
    
    var itemCount : Int = 0
    var color = DCColor.Red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("view address \(unsafeAddressOf(collectionView!))")
    }

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailCell", forIndexPath: indexPath)
        let colorValue = 1.0-(CGFloat(indexPath.item) + 1.0) / (2.0 * CGFloat(itemCount))
        
        cell.backgroundColor = UIColor(red: color == .Red ? colorValue : 0, green: color == .Green ? colorValue : 0, blue: color == .Blue ? colorValue : 0, alpha: 1.0)
        
        return cell
    }
}
