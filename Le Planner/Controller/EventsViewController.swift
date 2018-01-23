//
//  SecondViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventData.instance.getEventList().count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableCell", for: indexPath)
        //cell.textLabel?.text = eventsArray[indexPath.row]
        let event = EventData.instance.getEventList()[indexPath.row]
        cell.textLabel?.text = event.title
        cell.detailTextLabel?.text = event.description
        cell.imageView?.image = UIImage(named: (event.eventType?.rawValue)!)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Print here fix
        print(EventData.instance.getEventList()[indexPath.row].title)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

