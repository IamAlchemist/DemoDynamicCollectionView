//
//  DCSimpleCollectionViewController.swift
//  DemoCollectionView
//
//  Created by Wizard Li on 5/25/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class DCSimpleCollectionViewController : UICollectionViewController {
    
    var sectionCount : Int {
        return itemCounts.count
    }
    
    var itemCounts = [13, 16, 14]
    
    let smallLayout = DCFlowLayoutWithAnimations()
    let largeLayout = DCFlowLayoutWithAnimations()
    
    var isLargeItems : Bool = false
    
    var pincher : UIPinchGestureRecognizer!
    
    var selectedItem : Int?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        smallLayout.itemSize = CGSize(width: 50, height: 50)
        largeLayout.itemSize = CGSize(width: 200, height: 200)
        
        collectionView?.collectionViewLayout = smallLayout
        
        let insertItemButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(insertItem))
        
        let deleteItemButton = UIBarButtonItem(barButtonSystemItem: .Trash, target: self, action: #selector(deleteItem))
        
        let toggleSizeItemButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(toggleSizeItem))
        
        navigationItem.rightBarButtonItems = [insertItemButton, deleteItemButton, toggleSizeItemButton]
        
        pincher = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        
        collectionView?.addGestureRecognizer(pincher)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.delegate = self
    }
    
    func handlePinch(sender : UIPinchGestureRecognizer) {
        if sender.numberOfTouches() != 2 { return }
        
        switch sender.state {
        case .Began, .Changed:
            let p1 = sender.locationOfTouch(0, inView: collectionView)
            let p2 = sender.locationOfTouch(1, inView: collectionView)
            
            let xd = p1.x - p2.x
            let yd = p1.y - p2.y
            let distance = sqrt(xd*xd + yd*yd)
            
            if let layout = collectionView?.collectionViewLayout as? DCFlowLayoutWithAnimations {
                if let pintchItem = collectionView?.indexPathForItemAtPoint(CGPoint(x: 0.5*(p1.x+p2.x), y: 0.5*(p1.y+p2.y))) {
                    layout.resizeItemAtIndexPath(pintchItem, withPinchDistance: distance)
                    layout.invalidateLayout()
                }
            }
            
        case .Cancelled, .Ended:
            if let layout = collectionView?.collectionViewLayout as? DCFlowLayoutWithAnimations {
                collectionView?.performBatchUpdates({layout.resetPinchedItem()},
                                                    completion: nil)
            }
            
        default:
            break
        }
    }
    
    func insertItem() {
        let randomSection : Int = Int(arc4random_uniform(UInt32(sectionCount)))
        itemCounts[randomSection] += 1
        
        let item = Int(arc4random_uniform(UInt32(itemCounts[randomSection])))
        
        let indexPath = NSIndexPath(forItem: item, inSection: randomSection)
        
        collectionView?.insertItemsAtIndexPaths([indexPath])
    }
    
    func deleteItem() {
        let randomSection : Int = Int(arc4random_uniform(UInt32(sectionCount)))
        if itemCounts[randomSection] == 0 {
            return
        }
        
        itemCounts[randomSection] -= 1
        let item = Int(arc4random_uniform(UInt32(itemCounts[randomSection])))
        let indexPath = NSIndexPath(forItem: item, inSection: randomSection)
        
        collectionView?.deleteItemsAtIndexPaths([indexPath])
    }
    
    func toggleSizeItem() {
        if isLargeItems {
            isLargeItems = false
            collectionView?.setCollectionViewLayout(smallLayout, animated: true)
        }
        else {
            isLargeItems = true
            collectionView?.setCollectionViewLayout(largeLayout, animated: true)
        }
    }
}

// MARK: - navigation
extension DCSimpleCollectionViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let indexPath = collectionView?.indexPathsForSelectedItems()?.first,
            let dvc = segue.destinationViewController as? DCSimpleDetailViewController
            else { return }
        
        dvc.useLayoutToLayoutNavigationTransitions = true
        
        dvc.itemCount = itemCounts[indexPath.section]
        
        dvc.color = DCColor(rawValue: indexPath.section) ?? DCColor.Red
        
        selectedItem = indexPath.item
    }
}

// MARK: - Collection View Data Source
extension DCSimpleCollectionViewController{
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return sectionCount
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCounts[section]
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SimpleCell", forIndexPath: indexPath)
        
        let itemCount = self.collectionView(collectionView, numberOfItemsInSection: indexPath.section)
        
        let colorValue = 1.0-(CGFloat(indexPath.item)+1.0) / (2.0 * CGFloat(itemCount))
        
        cell.backgroundColor = UIColor(red: indexPath.section == 0 ? colorValue : 0.0,
                                       green: indexPath.section == 1 ? colorValue : 0.0,
                                       blue: indexPath.section == 2 ? colorValue : 0.0,
                                       alpha: 1.0)
        
        return cell
    }
}

extension DCSimpleCollectionViewController : UINavigationControllerDelegate {
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool) {
        
        if let dvc = viewController as? DCSimpleDetailViewController {
            pincher.enabled = false
            dvc.collectionView?.delegate = dvc
            dvc.collectionView?.dataSource = dvc
            
            guard let item = selectedItem else { return }
            dvc.collectionView?.scrollToItemAtIndexPath(NSIndexPath(forItem:item, inSection:0), atScrollPosition: [.CenteredVertically], animated: false)
        }
        else if (viewController == self) {
            collectionView?.dataSource = self
            collectionView?.delegate = self
            pincher.enabled = true
        }
    }
}





























