//
//  ViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/2/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
   
    
    //MARK: Declarations
    @IBOutlet weak var fNameField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var photoWindow: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var eyeColorField: UITextField!
    @IBOutlet weak var hairColorField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    
    
    //MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Draws the birthday field
        createDatePicker()
        
        // Draws the sex field
        sexPicker.delegate = self
        sexPicker.dataSource = self
        sexField.inputView = sexPicker
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
     override func prepare(for segue: UIStoryboardSegue, sender: Any?){
     guard let button = sender as? UIBarButtonItem, button === saveButton else{
     os_log("The save button was not pressed, cancelling.", log: OSLog.default, type: .debug)
     return
     }
     
     //        let f_name = fNameField.text
     //        let l_name = lNameField.text
     //        let alias = aliasField.text
     //        let birthday = birthdayField.text
     //        let sex = sexField.text
     //        let eye = eyeColorField.text
     //        let hair = hairColorField.text
     //        let height = heightField.text
     
     super.prepare(for: segue, sender: sender)
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
    var sexPicker = UIPickerView()
    
    func numberOfComponents(in sexPiceker: UIPickerView) -> Int {
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
    
    //MARK: Eye Color
    let eyeColors = ["Brown", "Blue", "Green", "Hazel", "Grey", "Other"]
    
    
    
    //MARK: Image
    @IBAction func addPhotoButton(_ sender: UIButton) {
        //Resigns keyboard
        birthdayField.resignFirstResponder()
        
        //Creates new image controller
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        photoWindow.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

