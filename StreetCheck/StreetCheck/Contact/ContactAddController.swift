//
//  ViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/2/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,
UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
   
    
    //MARK: Declarations
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fNameField: UITextField!
    @IBOutlet weak var mNameField: UITextField!
    @IBOutlet weak var lNameField: UITextField!
    @IBOutlet weak var aliasField: UITextField!
    @IBOutlet weak var birthdayField: UITextField!
    @IBOutlet weak var photoWindow: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var eyeColorField: UITextField!
    @IBOutlet weak var hairColorField: UITextField!
    @IBOutlet weak var sexField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var ethnicityField: UITextField!
    @IBOutlet weak var dist_marksField: UITextView!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var moField: UITextView!
    @IBOutlet weak var crimeField: UITextField!
    
    //MARK: Load
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        // Draws the sex field
        eyePicker.delegate = self
        eyePicker.dataSource = self
        eyeColorField.inputView = eyePicker
        sexPicker.delegate = self
        sexPicker.dataSource = self
        sexField.inputView = sexPicker
        hairColorPicker.delegate = self
        hairColorPicker.dataSource = self
        hairColorField.inputView = hairColorPicker
        
        
        photoWindow.contentMode = .scaleAspectFit
        dist_marksField.placeholder = "Distinguishing Marks:"
        moField.placeholder = "MO:"
        
        //Draws the birthday field
        fNameField.delegate = self
        mNameField.delegate = self
        lNameField.delegate = self
        aliasField.delegate = self
//        eyeColorField.delegate = self
        hairColorField.delegate = self
        heightField.delegate = self
        weightField.delegate = self
        addressField.delegate = self
        crimeField.delegate = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }

//    @objc func keyboardWillChange(notification: Notification){
//        print("Keyboard will show: \(notification.name.rawValue)")
//        view.frame.origin.y = -250
//    }
    
    //MARK: Navigation
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // Contact to add to file
    var contact: Contact?
    
    
    // MARK: Save
    // Save button that returns to home screen
    @IBOutlet weak var saveButton: UIBarButtonItem!
     override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        resignFirstResponder()
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let f_name = fNameField?.text
        let m_name = mNameField?.text
        let l_name = lNameField?.text
        let alias = aliasField?.text
        let birthday = birthdayField?.text
        let sex = sexField?.text
        let eye = eyeColorField?.text
        let hair = hairColorField?.text
        let height = heightField?.text
        let weight = weightField?.text
        let photo = photoWindow?.image
        let ethnicity = ethnicityField?.text
        let dist_marks = dist_marksField?.text
        let address = addressField?.text
        let mo = moField?.text
        let crime = crimeField?.text
        
        

        contact = Contact(first_name: f_name!,middle_name: m_name, last_name: l_name!, alias: alias, birthday: birthday!, MO: mo, height: height!, weight: weight!, hair_color: hair!, eye_color: eye!, sex: sex!, ethnicity: ethnicity!, dis_marks: dist_marks!, address: address, photo: photo!, crime: crime)
        
    }
    
    //MARK: Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fNameField.resignFirstResponder()
        mNameField.resignFirstResponder()
        lNameField.resignFirstResponder()
        aliasField.resignFirstResponder()
//        eyeColorField.resignFirstResponder()
        hairColorField.resignFirstResponder()
        heightField.resignFirstResponder()
        weightField.resignFirstResponder()
        ethnicityField.resignFirstResponder()
        addressField.resignFirstResponder()
        crimeField.resignFirstResponder()
        return true
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
    let eyeColors = ["Black", "Blue", "Brown", "Gray", "Green", "Hazel", "Maroon", "Multicolored", "Pink", "Unkown"]
    let hairColors = ["Black", "Blonde", "Blue", "Brown", "Gray", "Green", "Orange", "Pink", "Purple", "Red", "Sandy", "Unkown", "Bald", "White"]
    var sexPicker = UIPickerView()
    var eyePicker = UIPickerView()
    var hairColorPicker = UIPickerView()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == sexPicker){
             return sexes.count
        }
        else if (pickerView == eyePicker){
            return eyeColors.count
        }
        else if (pickerView == hairColorPicker){
            return hairColors.count
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == sexPicker){
            return sexes[row]
        }
        else if (pickerView == eyePicker){
            return eyeColors[row]
        }
        else if (pickerView == hairColorPicker){
            return hairColors[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == sexPicker){
            sexField.text = sexes[row]
            sexField.resignFirstResponder()
        }
        else if (pickerView == eyePicker){
            eyeColorField.text = eyeColors[row]
            eyeColorField.resignFirstResponder()
        }
        else if (pickerView == hairColorPicker){
            hairColorField.text = hairColors[row]
            hairColorField.resignFirstResponder()
        }
    }
    
    
    //MARK: Image
    @IBAction func addPhotoButton(_ sender: UIButton) {
        //Resigns keyboard
        view.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.allowsEditing = false
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }else{
                print("Camera not Availible")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
        
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

