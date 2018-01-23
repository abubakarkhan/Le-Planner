//
//  EventData.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import Foundation

class EventData {
    
    private var eventList : Array<Event> = []
    
    static let instance = EventData()
    
    private init(){
        eventList.append(Event(
            title: "Yoga class",
            description: "Trying out yoga today with John",
            date: CLong(NSDate().timeIntervalSince1970*1000),
            time: CLong(NSDate().timeIntervalSince1970*1000)))
        
        eventList.append(Event(
            title: "IOS Assignmnet 2",
            description: "Meetup with the team member to discuess the future approach",
            date: CLong(NSDate().timeIntervalSince1970*1000),
            time: CLong(NSDate().timeIntervalSince1970*1000)))
        
        eventList.append(Event(
            title: "Coffee Meetup",
            description: "Meeting John for coffe",
            date: CLong(NSDate().timeIntervalSince1970*1000),
            time: CLong(NSDate().timeIntervalSince1970*1000)))
        
        eventList.append(Event(
            title: "Meeting",
            description: "Meeting Jack",
            date: CLong(NSDate().timeIntervalSince1970*1000),
            time: CLong(NSDate().timeIntervalSince1970*1000)))
    }
    
    func getEventList() -> Array<Event>{
        return eventList
    }
    
}
