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
        
        collectionView?.dataSource = dataSource
        (collectionView?.collectionViewLayout as! PinterestViewLayout).delegate = self
    }
}
