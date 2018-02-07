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
    
    @IBOutlet weak var eyeSelectionButton: UIButton!
    @IBOutlet weak var viewPicker: UIPickerView!
    
    let eyeColors = ["Brown", "Blue", "Green", "Hazel", "Grey", "Other"]
    let birthdayPicker = UIDatePicker()
    
    //MARK: Load
    override func viewDidLoad() {
        
        viewPicker.delegate = self
        viewPicker.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewPicker.isHidden = true
        createDatePicker()
    }
    
    //MARK: Birthday
    
    func createDatePicker() {
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        //Done button for Toolbar
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        toolbar.setItems([done], animated: false)
        
        birthdayField.inputAccessoryView = toolbar
        birthdayField.inputView = birthdayPicker
        
        birthdayPicker.datePickerMode = .date
    }
    
    //MARK: Eyes
    @IBAction func eyeWasSelected(_ sender: UIButton) {
        if (viewPicker.isHidden){
            viewPicker.isHidden = false
            eyeSelectionButton.isHidden = true
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return eyeColors.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return eyeColors[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        eyeSelectionButton.setTitle(eyeColors[row], for: .normal)
        viewPicker.isHidden = true
        eyeSelectionButton.isHidden = false
    }
}

