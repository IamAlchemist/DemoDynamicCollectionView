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
        
        self.navigationController?.delegate = self
        
        dataSources = [DCCollectionDataSource(color: UIColor.redColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.orangeColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.yellowColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.greenColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.cyanColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.blueColor(), numberOfItems: 10),
                       DCCollectionDataSource(color: UIColor.purpleColor(), numberOfItems: 10)]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView?.reloadData()
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
        containerCell.layer.borderColor = UIColor.whiteColor().CGColor
        containerCell.layer.borderWidth = 2
        
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
        
        sourceCollectionView = collectionView
        
        self.navigationController?.pushViewController(dvc, animated: true)
    }
}

extension DCRootViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == self.collectionView {
            return CGSize(width: collectionView.bounds.width, height: 180)
        }
        else {
            return CGSize(width: 140, height: 140)
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        <#code#>
//    }
//    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        <#code#>
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
}

extension DCRootViewController : UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let sourceCollectionView = sourceCollectionView
            where fromVC == self && operation == .Push {
            
            let animator = DCLineToGridAnimator(fromCollectionView: sourceCollectionView)
            
            return animator
        }
        else {
            return nil
        }
    }
}
