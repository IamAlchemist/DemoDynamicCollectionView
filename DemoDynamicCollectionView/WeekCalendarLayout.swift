//
//  WeekCalendarLayout.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/11/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class WeekCalendarLayout : UICollectionViewLayout
{
    struct Const {
        static let DaysPerWeek : CGFloat = 7
        static let HoursPerDay : CGFloat = 24
        static let HorizontalSpacing : CGFloat = 6
        static let HeightPerHour : CGFloat = 50
        static let DayHeaderHeight : CGFloat = 40
        static let HourHeaderWidth : CGFloat = 60
    }
    
    var widthPerDay : CGFloat {
        return contentWidth / Const.DaysPerWeek
    }
    
    var contentWidth : CGFloat {
        return collectionViewContentSize().width - Const.HourHeaderWidth
    }
    
    override func collectionViewContentSize() -> CGSize {
        let contentWidth = collectionView!.bounds.width
        let contentHeight = Const.DayHeaderHeight + (Const.HeightPerHour * Const.HoursPerDay)
        
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes?
    {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        
        let totalWidth = collectionViewContentSize().width
        
        if elementKind == "DayHeaderView" {
            
            attributes.frame = CGRect(x: Const.HourHeaderWidth + (widthPerDay * CGFloat(indexPath.item)),
                y: 0,
                width: widthPerDay,
                height: Const.DayHeaderHeight)
            
            attributes.zIndex = -10;
        }
        else if elementKind == "HourHeaderView" {
            attributes.frame = CGRect(x: 0, y: Const.DayHeaderHeight + Const.HeightPerHour * CGFloat(indexPath.item),
                width: totalWidth, height: Const.HeightPerHour)
            attributes.zIndex = -10;
        }
        
        return attributes
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let dataSource = collectionView!.dataSource as! CalendarDataSource
        let event = dataSource.eventAtIndexPath(indexPath)
        
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        attributes.frame = frameForEvent(event)
        return attributes
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for indexPath in indexPathsOfItemsInRect(rect) {
            let attributes = layoutAttributesForItemAtIndexPath(indexPath)!
            layoutAttributes.append(attributes)
        }
        
        for indexPath in indexPathsOfDayHeaderViewsInRect(rect) {
            let attributes = layoutAttributesForSupplementaryViewOfKind("DayHeaderView", atIndexPath: indexPath)!
            layoutAttributes.append(attributes)
        }
        for indexPath in indexPathsOfHourHeaderViewsInRect(rect) {
            let attributes = layoutAttributesForSupplementaryViewOfKind("HourHeaderView", atIndexPath: indexPath)!
            layoutAttributes.append(attributes)
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    
    // MARK: - helper
    func dayIndexFromXCoordinate(x :CGFloat) -> Int {
        return max(0, Int((x - Const.HourHeaderWidth) / widthPerDay))
    }
    
    func hourIndexFromYCoordinate(y : CGFloat) -> Int {
        return max(0, Int((y - Const.DayHeaderHeight) / Const.HeightPerHour))
    }
    
    func indexPathsOfHourHeaderViewsInRect(rect : CGRect) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        
        let minHourIndex = hourIndexFromYCoordinate(CGRectGetMinY(rect))
        let maxHourIndex = hourIndexFromYCoordinate(CGRectGetMaxY(rect))
        
        for idx in minHourIndex...maxHourIndex {
            indexPaths.append(NSIndexPath(forItem: idx, inSection: 0))
        }
        
        return indexPaths
    }
    
    func indexPathsOfDayHeaderViewsInRect(rect : CGRect) -> [NSIndexPath] {
        var indexPaths = [NSIndexPath]()
        
        if CGRectGetMinY(rect) > Const.DayHeaderHeight {
            return indexPaths
        }
        
        let minDayIndex = dayIndexFromXCoordinate(CGRectGetMinX(rect))
        let maxDayIndex = dayIndexFromXCoordinate(CGRectGetMaxX(rect))
        
        for idx in minDayIndex...maxDayIndex {
            indexPaths.append(NSIndexPath(forItem: idx, inSection: 0))
        }
        
        return indexPaths
    }
    
    func indexPathsOfItemsInRect(rect: CGRect) -> [NSIndexPath] {
        let minVisibleDay = dayIndexFromXCoordinate(CGRectGetMinX(rect))
        let maxVisibleDay = dayIndexFromXCoordinate(CGRectGetMaxX(rect))
        let minVisibleHour = hourIndexFromYCoordinate(CGRectGetMinY(rect))
        let maxVisibleHour = hourIndexFromYCoordinate(CGRectGetMaxY(rect))
        
        let dataSource = collectionView!.dataSource as! CalendarDataSource
        return dataSource.indexPathsOfEventsBetweenMinDayIndex(minVisibleDay, maxDayIndex: maxVisibleDay, minStartHour: minVisibleHour, maxStartHour: maxVisibleHour)
    }
    
    func frameForEvent(event : CalendarEvent) -> CGRect {
        var frame = CGRectZero
        
        frame.origin.x = Const.HourHeaderWidth + widthPerDay * CGFloat(event.day)
        frame.origin.y = Const.DayHeaderHeight + Const.HeightPerHour * CGFloat(event.startHour)
        frame.size.width = widthPerDay
        frame.size.height = CGFloat(event.durationInHours) * Const.HeightPerHour
        
        frame = CGRectInset(frame, Const.HorizontalSpacing / 2, 0)
        
        return frame
    }
}
