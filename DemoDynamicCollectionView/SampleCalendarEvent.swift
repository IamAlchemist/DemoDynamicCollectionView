//
//  SampleCalendarEvent.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/11/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

class SampleCalendarEvent : CalendarEvent {
    
    static func randomEvent() -> CalendarEvent {
        let randomID = Int(arc4random_uniform(10000))
        let title = "\(randomID)"
        
        let randomDay = Int(arc4random_uniform(7));
        let randomStartHour = Int(arc4random_uniform(20))
        let randomDuration = Int(arc4random_uniform(5)) + 1
        
        return SampleCalendarEvent(title: title, day: randomDay, startHour: randomStartHour, durationInHours: randomDuration)
    }
    
    var title : String
    var day : Int
    var startHour : Int
    var durationInHours : Int
    
    init(title: String, day : Int, startHour : Int, durationInHours : Int){
        self.title = title
        self.day = day
        self.startHour = startHour
        self.durationInHours = durationInHours
    }
}