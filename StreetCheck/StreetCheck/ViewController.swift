//
//  ViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/2/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate{
   
    
    //MARK: Declarations
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    
    
    @IBOutlet weak var eyeSelectionButton: UIButton!
    //@IBOutlet weak var viewPicker: UIPickerView!
    
    let eyeColors = ["Brown", "Blue", "Green", "Hazel", "Grey", "Other"]
    
    //MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createDatePicker()
        
        sexPicker.delegate = self
        sexPicker.dataSource = self
        
        sexField.inputView = sexPicker
    }
    
    //MARK: Birthday
    
    // Birthday Picker
    let birthdayPicker = UIDatePicker()
    
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Done button for Toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
        
        birthdayField.inputAccessoryView = toolbar
        birthdayField.inputView = birthdayPicker
        
        birthdayPicker.datePickerMode = .date
    }
    
    @objc func donePressed(){
        //Format Date
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        let dateString = formatter.string(from: birthdayPicker.date)
        
        birthdayField.text = "\(dateString)"
        self.view.endEditing(true)
    }
    
    //MARK: Sex
    
    // Sex Array
    let sexes = ["Male", "Female", "Other"]
    let sexPicker = UIPickerView()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sexes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sexes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        sexField.text = sexes[row]
        sexField.resignFirstResponder()
    }
    
    
}

