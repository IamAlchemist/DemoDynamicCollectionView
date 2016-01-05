//
//  SpringyCollectionVeiwDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/5/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class SpringyCollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 120
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SpringyCollectionViewCell", forIndexPath: indexPath)
        
        cell.backgroundColor = UIColor.orangeColor()
        
        return cell
    }
}
