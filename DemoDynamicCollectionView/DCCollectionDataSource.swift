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
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        <#code#>
    }
}
