//
//  NotesViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.tableFooterView = UIView()
    }
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotesData.instance.getNotesList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentNote = NotesData.instance.getNotesList()[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteCell
        
        cell.setNoteCell(note: currentNote)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentNote = NotesData.instance.getNotesList()[indexPath.row]
        let messageAlert = "\n\n *To Delete Entry Swipe Left On Item"
        
        let alert = UIAlertController(title: currentNote.title,
            message: currentNote.body + messageAlert, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Dimiss", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            NotesData.instance.deleteNote(index: indexPath.row)
            tableView.reloadData()
        }
        
        return [deleteAction]
    }
    
}
