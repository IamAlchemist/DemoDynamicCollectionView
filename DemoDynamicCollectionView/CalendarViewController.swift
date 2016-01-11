//
//  CalendarViewController.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/11/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class CalendarViewController : UICollectionViewController
{
    var calendarDataSource = CalendarDataSource()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        collectionView?.dataSource = calendarDataSource
        
        let nib = UINib(nibName: "CalendarHeaderView", bundle: nil)
        collectionView?.registerNib(nib, forSupplementaryViewOfKind: "DayHeaderView", withReuseIdentifier: "CalendarHeaderView")
        collectionView?.registerNib(nib, forSupplementaryViewOfKind: "HourHeaderView", withReuseIdentifier: "CalendarHeaderView")
        
        calendarDataSource.configureCell = { (cell, event) in
            cell.title.text = event.title
        }
        
        calendarDataSource.configureHeaderView = { (headerView, kind, indexPath) in
            switch kind {
            case "DayHeaderView":
                headerView.title.text = "Day \(indexPath.item + 1)"
            case "HourHeaderView":
                headerView.title.text = String(format: "%2d:00", indexPath.item + 1)
            default:
                break
            }
        }
    }
}
