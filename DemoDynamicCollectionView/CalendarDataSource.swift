//
//  CalendarDataSource.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/11/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class CalendarDataSource : NSObject, UICollectionViewDataSource {
    
    var configureCell : ((cell: CalendarEventCell, event: CalendarEvent) -> Void)?
    
    var configureHeaderView : ((headerView : CalendarHeaderView, kind : String, indexPath : NSIndexPath) -> Void)?
    
    var events = [CalendarEvent]()
    
    override init() {
        super.init()
        generateSampleData()
    }
    
    func generateSampleData()
    {
        for idx in 0..<20 {
            var event = SampleCalendarEvent.randomEvent();
            event.title = "E \(idx)"
            events.append(event)
        }
    }
    
    func eventAtIndexPath(indexPath: NSIndexPath) -> CalendarEvent {
        return events[indexPath.item]
    }
    
    func indexPathsOfEventsBetweenMinDayIndex(minDayIndex: Int, maxDayIndex: Int, minStartHour: Int, maxStartHour: Int) -> [NSIndexPath]
    {
        var result = [NSIndexPath]()
        
        for (idx, event) in events.enumerate()
        {
            if event.day >= minDayIndex && event.day <= maxDayIndex && event.startHour >= minStartHour && event.startHour <= maxStartHour
            {
                result.append(NSIndexPath(forItem: idx, inSection: 0))
            }
        }
        
        return result
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CalendarEventCell", forIndexPath: indexPath) as! CalendarEventCell
        
        let event = events[indexPath.item]

        configureCell?(cell: cell, event: event)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView
    {
        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier:"CalendarHeaderView", forIndexPath: indexPath) as! CalendarHeaderView
        
        configureHeaderView?(headerView: headerView, kind: kind, indexPath: indexPath)
        
        return headerView
    }
}
