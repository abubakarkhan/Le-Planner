//
//  AddNoteViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 24/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import CoreData
import SwiftySound

class AddNoteViewController: UIViewController {
    
    @IBOutlet weak var noteTitleField: UITextField!
    @IBOutlet weak var noteDetailField: UITextView!
    
    var delegate : AddNoteProtocol?
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addButton(_ sender: Any) {
        
        if !(noteTitleField.text?.isEmpty)! && !(noteDetailField.text?.isEmpty)!{
            newNoteAddedAlert()
        } else {
            noteNotAddedAlert()
        }    
    }
    
    private func noteNotAddedAlert(){
        let alert = UIAlertController(title: "Failed",
                                      message: "Your note was not added \nPlease fill in empty fields",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss",
                                                               comment: "Default action"), style: .`default`, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        Sound.play(file: "errorSound.wav")
    }
    
    private func newNoteAddedAlert(){
        //add note
        let newNote = Note(context: context)
        newNote.title = noteTitleField.text!
        newNote.body = noteDetailField.text!
        
        //Delegate
        delegate?.newNoteData(data: newNote)
        
        //Build alert for note added
        let alert = UIAlertController(title: "Note Added",
                                      message: "Your note was added",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            self.navigateToPreviousScreen()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    private func navigateToPreviousScreen(){
        //navigate back to event list
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}
