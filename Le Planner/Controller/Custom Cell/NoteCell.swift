//
//  NoteCell.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var noteBody: UILabel!
    @IBOutlet weak var noteFirstLetterLabel: UILabel!
    
    
    func setNoteCell(note: Note){
        noteTitle.text = note.title
        noteBody.text = note.body
        
        let firstLetter = note.title![(note.title?.startIndex)!]
        noteFirstLetterLabel.text = "\(firstLetter)"
        
    }
}
