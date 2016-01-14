//
//  PinterestViewController.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 1/13/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class PinterestViewController : UICollectionViewController {
    
    var dataSource = PinterestDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patternImage = UIImage(named: "Pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        }
        
        collectionView?.backgroundColor = UIColor.clearColor()
        collectionView?.contentInset = UIEdgeInsets(top: 23, left: 5, bottom: 5, right: 5)
    
        collectionView?.dataSource = dataSource
        (collectionView?.collectionViewLayout as! PinterestViewLayout).delegate = dataSource
    }
}

