//
//  EventsViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import CoreData

class EventsViewController: UIViewController {
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    var eventArray = [Event]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        //hide separator for empty cell
        eventsTableView.tableFooterView = UIView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadNotes()
    }
    
    //MARK: - Save events data
    func saveEvents(){
        
        do {
            try context.save()
        } catch{
            print("Error saving notes: \(error)")
        }
        
        eventsTableView.reloadData()
        
    }
    //MARK: - Load events data
    func loadNotes(){
        
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        
        do {
            eventArray = try context.fetch(request)
        } catch {
            print("Error loading events: \(error)")
        }
        
        eventsTableView.reloadData()
    }


}

//MARK: - Table View

extension EventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentEvent = eventArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as! EventCell
        
        cell.setEventCell(event: currentEvent)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            self.context.delete(self.eventArray[indexPath.row])
            self.eventArray.remove(at: indexPath.row)
            self.saveEvents()
        }
        
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        
        //selected event
        let eventSelected = eventArray[indexPath.row]
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alerBody = eventSelected.desc! + "\n" +
            "\(Date(timeIntervalSince1970: eventSelected.date))" + "\n" +
            eventSelected.type! + " Event"
        
        let messageAlert = "\n\n *To Delete Entry Swipe Left On Item"
        
        let alert = UIAlertController(title: eventSelected.title!,
                                      message: alerBody + messageAlert, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Dimiss", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
