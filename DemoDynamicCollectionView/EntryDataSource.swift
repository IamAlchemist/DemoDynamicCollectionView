//
//  EntryDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/5/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class EntryDataSource: NSObject, UITableViewDataSource {
    
    var data = ["Springy", "Newtownian", "SimpleDynamic", "Calendar", "Pinterest", "SnapDynamic"]
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell", forIndexPath: indexPath)
        
        cell.configForBasicCell(data[indexPath.row])
        
        return cell
    }
    
    func segueIdentifierWithIndentifier(indexPath : NSIndexPath) -> String {
        return data[indexPath.row] + "Segue"
    }
}
