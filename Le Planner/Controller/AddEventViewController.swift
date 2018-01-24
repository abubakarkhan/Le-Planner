//
//  AddEventViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 23/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    let arrayEventType = [EventType.Exercise,
                          EventType.Leisure,
                          EventType.Meeting,
                          EventType.Other,
                          EventType.Study,
                          EventType.Work]
    
    var eventType : EventType?
    var eventDateTime : Date?
    
    override func viewDidLoad() {
        pickerView.delegate = self
        pickerView.dataSource = self
        super.viewDidLoad()
    
        let datePicker = UIDatePicker()
        
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime

        datePicker.addTarget(self,
                             action: #selector(AddEventViewController.datePickerValueChange(sender:)),
                             for: UIControlEvents.valueChanged)

        dateField.inputView = datePicker

    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return arrayEventType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayEventType[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventType = arrayEventType[row]
        print(arrayEventType[row].rawValue)
    }
    
    @IBAction func addEventBtn(_ sender: Any) {
        var et : EventType?
        
        if eventType != nil {
            et = eventType
        }else{
            et = EventType.Exercise
        }
        
        if eventDateTime == nil {
            eventDateTime = Date()
        }
        //FIx ************************ emtyp string
        
        EventData.instance.addEvent(event: Event(title: titleField.text!,
                                                 description: descField.text!,
                                                 dateTime: eventDateTime!,
                                                 eventType: et!))
        
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
        
        eventDateTime = sender.date
        
        print(sender.date)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Key board fix
        view.endEditing(true)
    }
    
}
