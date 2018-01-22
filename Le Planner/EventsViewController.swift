//
//  SecondViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 22/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class EventsViewController: UITableViewController {

    let eventsArray = ["Party","Meeting","Conference","Work","Exam"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventTableCell", for: indexPath)
        cell.textLabel?.text = eventsArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(eventsArray[indexPath.row])
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

