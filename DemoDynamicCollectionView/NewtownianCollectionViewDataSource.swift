//
//  NewtownianCollectionViewDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/6/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class NewtownianCollectionViewDataSource : NSObject, UICollectionViewDataSource {
    
    var data = [String]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NewtownianCell", forIndexPath: indexPath) as! NewtownianCell
        let index = Int.init(data[indexPath.row]) == nil ? 0 : Int.init(data[indexPath.row])!
        cell.configWithImageName("\(index % 5)")
        return cell;
    }
    
    func increaseItem() {
        data.append("\(data.count + 1)")
    }
}
