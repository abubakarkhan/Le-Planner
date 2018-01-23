//
//  Event.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import Foundation

enum EventType: String {
    
    case Meeting
    case Leisure
    case Exercise
    case Study
    case Work
    case Other
}

class Event {
    
    static var id : Int = 0
    var title : String = ""
    var description : String = ""
    var date : CLong = 0
    var time : CLong = 0
    var eventType : EventType?
    
    init(title: String, description: String, date: CLong, time: CLong, eventType: EventType) {
        Event.id += 1
        self.title = title
        self.description = description
        self.date = date
        self.time = time
        self.eventType = eventType
    }
    
}
