//
//  DCUICollectionViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 5/25/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class DCDetailViewController : UICollectionViewController {
    var dataSource : UICollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.dataSource = dataSource
        self.collectionView?.reloadData()
    }
}

