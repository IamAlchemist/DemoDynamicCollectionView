//
//  SpringyCollectionViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/5/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class SpringyCollectionViewController : UICollectionViewController {
    
    var dataSource : SpringyCollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.dataSource = dataSource
    }
}
