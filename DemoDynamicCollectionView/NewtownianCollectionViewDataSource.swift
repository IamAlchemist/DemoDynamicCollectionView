//
//  NewtownianCollectionViewDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/6/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class NewtownianCollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    var data = [Int]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewtownianCell", forIndexPath: indexPath) as! NewtownianCell
        let index = data[indexPath.item]
        cell.configWithImageName("\(index % 5)")
        return cell;
    }
    
    func decreaseItem() {
        data.removeFirst()
    }
    
    func increaseItem() {
        if data.count == 0 {
            data.append(0)
        }
        else {
            data.append(data[data.count - 1] + 1)
        }
    }
}
