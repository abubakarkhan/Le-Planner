//
//  NotesViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    @IBOutlet weak var notesTableView: UITableView!
    
    var noteArray = [Note]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.tableFooterView = UIView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadNotes()
    }
    //MARK: - Save notes data
    func saveNotes(){
        
        do {
            try context.save()
        } catch{
            print("Error saving notes: \(error)")
        }
        
        notesTableView.reloadData()
        
    }
    //MARK: - Load notes data
    func loadNotes(){
        
        let request : NSFetchRequest<Note> = Note.fetchRequest()
        
        do {
            noteArray = try context.fetch(request)
        } catch {
            print("Error loading notesL \(error)")
        }
        
        notesTableView.reloadData()
    }
}

//MARK: - Table view

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentNote = noteArray[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell") as! NoteCell
        
        cell.setNoteCell(note: currentNote)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let currentNote = noteArray[indexPath.row]
        let messageAlert = "\n\n *To Delete Entry Swipe Left On Item"
        
        let alert = UIAlertController(title: currentNote.title!,
            message: currentNote.body! + messageAlert, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Dimiss", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, index) in
            self.context.delete(self.noteArray[indexPath.row])
            self.noteArray.remove(at: indexPath.row)
            self.saveNotes()
        }
        
        return [deleteAction]
    }
    
}
