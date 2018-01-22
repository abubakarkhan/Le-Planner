//
//  Event.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import Foundation

class Event {
    
    static var id : Int = 0
    var title : String = ""
    var description : String = ""
    var date : CLong = 0
    var time : CLong = 0
    
    init(title: String, description: String, date: CLong, time: CLong) {
        Event.id += 1
        self.title = title
        self.description = description
        self.date = date
        self.time = time
    }
    
}
