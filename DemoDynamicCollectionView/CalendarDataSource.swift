//
//  CalendarDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/11/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class CalendarDataSource : NSObject, UICollectionViewDataSource {
    
    var configureCell : ((cell: CalendarEventCell, indexPath: NSIndexPath, event: CalendarEvent) -> Void)?
    
    var configureHeaderView : ((headerView : CalendarHeaderView, kind : String, indexPath : NSIndexPath))?
    
    var events = [CalendarEvent]()
    
    func generateSampleData()
    {
        for _ in 1..<20 {
            let event = SampleCalendarEvent.randomEvent();
            events.append(event)
        }
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CalendarEventCell", forIndexPath: indexPath)
        
        return cell
    }
}
