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
        //Date formatter
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.medium
        
        eventImage.image = UIImage (named: event.eventType.rawValue)
        eventTitle.text = event.title
        eventDesc.text = event.description
        eventDate.text = formatter.string(from: event.dateTime)
    }

}
