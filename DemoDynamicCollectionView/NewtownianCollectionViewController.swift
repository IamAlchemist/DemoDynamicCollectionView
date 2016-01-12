//
//  NewtownianCollectionViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/6/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class NewtownianCollectionViewController : UICollectionViewController {
    
    var collectionViewDatasource : NewtownianCollectionViewDataSource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewDatasource = NewtownianCollectionViewDataSource()
        collectionView!.dataSource = collectionViewDatasource
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        collectionViewDatasource?.increaseItem()
        collectionView?.reloadData()
    }
    
    @IBAction func deleteButtonTapped(sender: UIBarButtonItem) {
        collectionViewDatasource?.decreaseItem()
        collectionView?.reloadData()
    }
}
