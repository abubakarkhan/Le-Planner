//
//  EventCell.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDesc: UILabel!
    
    func setEventCell(event: Event){
        
        setEventIcon(eventType: event.type!)
        eventTitle.text = event.title!
        eventDesc.text = event.desc!
        eventDate.text = String(describing: Date(timeIntervalSince1970: event.date))
    }
    
    func setEventIcon(eventType: String){
        
        var iconStr = ""
        
        switch eventType {
        case "Exercise":
            iconStr = "Exercise"
            break
        case "Meeting":
            iconStr = "Meeting"
            break
        case "Work":
            iconStr = "Work"
            break
        case "Leisure":
            iconStr = "Leisure"
            break
        case "Study":
            iconStr = "Study"
            break
        default:
            iconStr = "Other"
            break
        }
        
        eventImage.image = UIImage (named: iconStr)
        
    }

}
