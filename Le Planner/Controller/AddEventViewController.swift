//
//  AddEventViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 23/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime

        datePicker.addTarget(self,
                             action: #selector(AddEventViewController.datePickerValueChange(sender:)),
                             for: UIControlEvents.valueChanged)

        dateField.inputView = datePicker

    }
    @IBAction func addEventBtn(_ sender: Any) {
        //Build alert for meeting added
        let alert = UIAlertController(title: "Event Added",
                                      message: "Your event was added",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            self.navigateToPreviousScreen()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func navigateToPreviousScreen(){
        //navigate back to event list
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func datePickerValueChange(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.medium

        dateField.text = formatter.string(from: sender.date)
        
        print(sender.date)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Key board fix
        view.endEditing(true)
    }
    
}
