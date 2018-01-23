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

struct Event {
    
    static var id : Int = 0
    var title : String
    var description : String
    var dateTime : Date
    var eventType : EventType
    
    init(title: String, description: String, dateTime: Date, eventType: EventType) {
        Event.id += 1
        self.title = title
        self.description = description
        self.dateTime = dateTime
        self.eventType = eventType
    }

}
