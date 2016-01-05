//
//  ViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/5/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {
    
    var entryDataSource : EntryDataSource?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        entryDataSource = EntryDataSource()
        
        self.tableView.dataSource = entryDataSource as? UITableViewDataSource
    }
}

