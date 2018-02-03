//
//  AddEventViewController.swift
//  Le Planner
//
//  Created by Abubakar Khan on 23/1/18.
//  Copyright © 2018 Abubakar Khan. All rights reserved.
//

import UIKit
import CoreData
import SwiftySound

class AddEventViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var descField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var eventTypeTextFIeld: UITextField!
    
    let arrayEventType = ["Exercise","Leisure","Meeting","Other","Study","Work"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var eventArray = [Event]()
    var eventDate : Double?
    
    
    override func viewDidLoad() {
        let pickerView = UIPickerView()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        //Spinner input for event type field
        eventTypeTextFIeld.inputView = pickerView
        
        super.viewDidLoad()
    
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        datePicker.addTarget(self,
                             action: #selector(AddEventViewController.datePickerValueChange(sender:)),
                             for: UIControlEvents.valueChanged)

        //Assign date picker inupt
        dateField.inputView = datePicker
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arrayEventType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayEventType[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eventTypeTextFIeld.text = arrayEventType[row]
    }
    
    @IBAction func addEventBtn(_ sender: Any) {
        
        //Optimize for emty strings later ***
        if !(titleField.text?.isEmpty)! &&
            !(descField.text?.isEmpty)! &&
            !(dateField.text?.isEmpty)! &&
            !(eventTypeTextFIeld.text?.isEmpty)!{
            addNewEvent()
            eventAddedAlert()
        }else{
            eventNotAddedAlert()
        }
    }
    //MARKS: - Alerts
    func eventNotAddedAlert(){
        //Build alert for event not added
        let alert = UIAlertController(title: "Failed",
                                      message: "Your event was not added \nPlease fill in empty fields",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Dismiss", comment: "Default action"), style: .`default`, handler: nil))
        self.present(alert, animated: true, completion: nil)
        Sound.play(file: "errorSound.wav")
    }
    
    func eventAddedAlert(){
        //Build alert for event added
        let alert = UIAlertController(title: "Event Added",
                                      message: "Your event was added",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .`default`, handler: { _ in
            self.navigateToPreviousScreen()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Adding events
    func addNewEvent(){
        //create new event object and add to array
        let eventAdd = Event(context: context)
        
        eventAdd.title = titleField.text!
        eventAdd.desc = descField .text!
        eventAdd.type = verifyEventType()
        
        if eventDate == nil{
            eventAdd.date = Date().timeIntervalSince1970
        }
        else {
            eventAdd.date = eventDate!
        }
        
        eventArray.append(eventAdd)
        saveEvent()
    }
    
    func saveEvent(){
        do{
            try context.save()
        }catch {
            print("Error saving new event: \(error)")
        }
    }
    
    func verifyEventType() -> String{
        if arrayEventType.contains(eventTypeTextFIeld.text!) {
            return eventTypeTextFIeld.text!
        } else {
            return "Other"
        }
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
        
        eventDate = sender.date.timeIntervalSince1970
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Key board fix
        view.endEditing(true)
    }
    
}
