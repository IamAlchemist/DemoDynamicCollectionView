//
//  ViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/5/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    var entryDataSource = EntryDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = entryDataSource as UITableViewDataSource
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let segueIdentifier = entryDataSource.segueIdentifierWithIndentifier(indexPath)
        performSegueWithIdentifier(segueIdentifier, sender: self)
    }
}

