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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.date

        datePicker.addTarget(self, action: #selector(AddEventViewController.datePickerValueChange(sender:)),
                             for: UIControlEvents.valueChanged)

        dateField.inputView = datePicker

    }

    @objc func datePickerValueChange(sender: UIDatePicker){
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.medium
        formatter.timeStyle = DateFormatter.Style.none

        dateField.text = formatter.string(from: sender.date)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
