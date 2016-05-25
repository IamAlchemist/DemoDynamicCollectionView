//
//  DCRootViewController.swift
//  DemoDynamicCollectionView
//
//  Created by wizard on 5/25/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class DCRootViewController : UICollectionViewController {
    var dataSources = [DCCollectionDataSource]()
    var sourceCollectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSources = [DCCollectionDataSource(color: UIColor.redColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.orangeColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.yellowColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.greenColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.cyanColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.blueColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.purpleColor(), numberOfItems: 10)]
    }
}

extension DCRootViewController {
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return dataSources.count
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let containerCell = collectionView.dequeueReusableCellWithReuseIdentifier("ContainerCell", forIndexPath: indexPath) as! DCContainerCell
        
        let childCollectionView = containerCell.collectionView
        
        childCollectionView.dataSource = dataSources[indexPath.section];
        
        return containerCell
    }
}

extension DCRootViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        guard let dvc = self.storyboard?.instantiateViewControllerWithIdentifier("DCDetailViewController") as? DCDetailViewController
            else { return }
        
        dvc.dataSource = collectionView.dataSource
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension DCRootViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: collectionView.bounds.width, height: 200)
        }
        else {
            return CGSize(width: 180, height: 180)
        }
    }
}
