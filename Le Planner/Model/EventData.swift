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
            dateTime: Date(),
            eventType: EventType.Exercise))
        
        eventList.append(Event(
            title: "IOS Assignmnet 2",
            description: "Meetup with the team member to discuess the future approach",
            dateTime: Date(),
            eventType: EventType.Study))
        
        eventList.append(Event(
            title: "Coffee Meetup",
            description: "Meeting John for coffe",
            dateTime: Date(),
            eventType: EventType.Meeting))
        
        eventList.append(Event(
            title: "Meeting",
            description: "Meeting Jack for rock climbing",
            dateTime: Date(),
            eventType: EventType.Leisure))
        
        eventList.append(Event(
            title: "Design Team Meeting",
            description: "Finalising design mockups",
            dateTime: Date(),
            eventType: EventType.Work))
        
        eventList.append(Event(
            title: "Pick up Adam",
            description: "Pick up Adam at the airport at 10:00 pm",
            dateTime: Date(),
            eventType: EventType.Other))
    }
    
    func getEventList() -> Array<Event>{
        return eventList
    }
    func addEvent(event: Event){
        eventList.append(event)
    }
    
}
