//
//  EventData.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import Foundation

class EventData {
    
    var eventList : Array<Event> = []
    
    private static var instance : EventData?
    
    static func getInstance() -> EventData {
        if instance == nil {
            instance = EventData()
        }
        return instance!
    }
    
    private init(){
        eventList.append(Event(title: "Yoga class",
                               description: "Trying out yoga today with John",
                               date: CLong(NSDate().timeIntervalSince1970*1000),
                               time: CLong(NSDate().timeIntervalSince1970*1000)))
    }
    
    private func getEventList() -> Array<Event>{
        return eventList
    }
    
}
