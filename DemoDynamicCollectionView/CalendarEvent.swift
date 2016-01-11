//
//  CalendarEvent.swift
//  DemoDynamicCollectionView
//
//  Created by Wizard Li on 1/11/16.
//  Copyright © 2016 morgenworks. All rights reserved.
//

import UIKit

protocol CalendarEvent {
    var title : String { get set }
    var day : Int { get set }
    var startHour : Int { get set }
    var durationInHours : Int { get set }
}
