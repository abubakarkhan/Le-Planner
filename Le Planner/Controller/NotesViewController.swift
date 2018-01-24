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
    
}
