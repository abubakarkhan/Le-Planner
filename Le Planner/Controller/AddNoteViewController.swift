//
//  AddNoteViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteDetailField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    @IBAction func addButton(_ sender: Any) {
        
        if !(noteTitleField.text?.isEmpty)! && !(noteDetailField.text?.isEmpty)!{
            //add note if fields no blank
            addNote(title: noteTitleField.text!, body: noteDetailField.text!)
            
            //Build alert for meeting added
            let alert = UIAlertController(title: "Note Added",
                                          message: "Your note was added",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
                self.navigateToPreviousScreen()
            }))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Failed",
                                          message: "Your note was not added. Empty Fields",
                                          preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss",
                                                                   comment: "Default action"), style: .`default`, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
    
    }
    
    func addNote(title: String, body: String){
        let newNote = Note(title: title, body: body)
        NotesData.instance.addNote(note: newNote)
    }
    
    func navigateToPreviousScreen(){
        //navigate back to event list
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
}
