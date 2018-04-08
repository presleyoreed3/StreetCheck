//
//  ContactEditController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/28/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

class ContactEditController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    
    var contactToEdit: Contact?
    
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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var terrorismField: UITextField!
    @IBOutlet weak var complexionField: UITextField!
    @IBOutlet weak var buildField: UITextField!
    @IBOutlet weak var hairStyleField: UITextField!
    @IBOutlet weak var notesField: UITextView!
    
    //MARK: Picker Declarations
    var sexPicker = UIPickerView()
    var eyePicker = UIPickerView()
    var hairColorPicker = UIPickerView()
    var hairStylePicker = UIPickerView()
    var complexionPicker = UIPickerView()
    var crimesPicker = UIPickerView()
    var terrorismPicker = UIPickerView()
    var buildPicker = UIPickerView()
    var racePicker = UIPickerView()
    var heightPicker = UIPickerView()
    var weightPicker = UIPickerView()
    
    //MARK: Picker Fields
    let sexes = ["Male", "Female", "Other"]
    let eyeColors = ["Black", "Blue", "Brown", "Gray", "Green", "Hazel", "Maroon", "Multicolored", "Pink", "Unkown"]
    let hairColors = ["Black", "Blonde", "Blue", "Brown", "Gray", "Green", "Orange", "Pink", "Purple", "Red", "Sandy", "Unkown", "Bald", "White"]
    let hairStyle = ["Afro", "Balding", "Bangs", "Bob", "Bowl", "Braided", "Bun", "Buzz Cut", "Corn Rows", "Curly/Perm", "Dreadlocks", "Dyed", "Fade", "Feathered", "Flat Top", "Jerry Curl", "Long", "Messy", "Mohawk", "Mullet", "Pony Tail", "Punk", "Shaved Bald", "Shaved in Design", "Short", "Shoulder Length", "Short", "Spiked", "Straight"]
    let complexions = ["Albino", "Black", "Dark", "Dark Down", "Fair", "Light", "Light Brown", "Medium", "Medium Brown", "Normal", "Olive", "Red", "Ruddy", "Sallow", "Yellow"]
    let crimes = ["", "Homicide", "Rape", "Robbery", "Assault", "Burglary", "Theft", "Arson", "Kidnapping", "Forgary/Fraud", "Vandalism", "Weapons", "Prostitution", "Gambling", "DUI", "Harassment"]
    let terrorisms = ["", "Domestic Terrorism", "International Terrorism", "Hate Crimes", "Race Supremacy", "Environmental Extremists", "Animal Rights Extremists", "Anarchist Extremists", "Anti-abortion Extremists", "Lone Wolf Extremist", "Religious Extremists", "Sovereign Citizen Extremists", "Militia Extremists", "N/A"]
    let builds = ["Fit", "Heavy", "Medium", "Muscular", "Obese", "Pregnant", "Slight", "Slim", "Stocky", "Short", "Tall"]
    let races = ["Black", "Indian", "Asian", "White", "Unkown"]
    let textField = UITextField()
    let feetList = Array(3...9)
    let inchList = Array(0...11)
    let weights = Array (60...400)
    let numberOfComponents = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDatePicker()
        
        fNameField.delegate = self
        mNameField.delegate = self
        lNameField.delegate = self
        aliasField.delegate = self
        heightField.delegate = self
        weightField.delegate = self
        addressField.delegate = self
        
        // Draws the eye field
        eyePicker.delegate = self
        eyePicker.dataSource = self
        eyeColorField.inputView = eyePicker
        // Draws the sex field
        sexPicker.delegate = self
        sexPicker.dataSource = self
        sexField.inputView = sexPicker
        // Draws the hair color field
        hairColorPicker.delegate = self
        hairColorPicker.dataSource = self
        hairColorField.inputView = hairColorPicker
        // Draws the hair style field
        hairStylePicker.delegate = self
        hairStylePicker.dataSource = self
        hairStyleField.inputView = hairStylePicker
        // Draws the complexion field
        complexionPicker.delegate = self
        complexionPicker.dataSource = self
        complexionField.inputView = complexionPicker
        // Draws the crimes field
        crimesPicker.delegate = self
        crimesPicker.dataSource = self
        crimeField.inputView = crimesPicker
        // Draws the terrorism field
        terrorismPicker.delegate = self
        terrorismPicker.dataSource = self
        terrorismField.inputView = terrorismPicker
        // Draws the build field
        buildPicker.delegate = self
        buildPicker.dataSource = self
        buildField.inputView = buildPicker
        // Draws the race field
        racePicker.delegate = self
        racePicker.dataSource = self
        ethnicityField.inputView = racePicker
        
        weightPicker.delegate = self
        weightPicker.dataSource = self
        weightField.inputView = weightPicker
        
        heightPicker.delegate = self
        heightPicker.dataSource = self
        heightField.inputView = heightPicker
        
        //Preloads the data into the appropriate fields
        fNameField.text = contactToEdit?.first_name
        mNameField.text = contactToEdit?.middle_name
        lNameField.text = contactToEdit?.last_name
        aliasField.text = contactToEdit?.alias
        birthdayField.text = contactToEdit?.birthday
        photoWindow.image = contactToEdit?.photo
        eyeColorField.text = contactToEdit?.eye_color
        hairColorField.text = contactToEdit?.hair_color
        sexField.text = contactToEdit?.sex
        heightField.text = contactToEdit?.height
        weightField.text = contactToEdit?.weight
        ethnicityField.text = contactToEdit?.ethnicity
        dist_marksField.text = contactToEdit?.dis_marks
        addressField.text = contactToEdit?.address
        crimeField.text = contactToEdit?.crime
        moField.text = contactToEdit?.MO
        hairStyleField.text = contactToEdit?.hairStyle
        terrorismField.text = contactToEdit?.terrorism
        complexionField.text = contactToEdit?.complexion
        buildField.text = contactToEdit?.build
        notesField.text = contactToEdit?.notes
        
        photoWindow.contentMode = .scaleAspectFit
        dist_marksField.placeholder = "Distinguishing Marks"
        moField.placeholder = "MO"
        notesField.placeholder = "Notes"
        
        
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
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
        let hairStyle = hairStyleField?.text
        let build = buildField?.text
        let terrorism = terrorismField?.text
        let complexion = complexionField?.text
        let notes = notesField?.text
        let currentDateTime = Date()
        
        
        contactToEdit = Contact(first_name: f_name!,middle_name: m_name, last_name: l_name!, alias: alias, birthday: birthday!, MO: mo, height: height!, weight: weight!, hair_color: hair!, eye_color: eye!, sex: sex!, ethnicity: ethnicity!, dis_marks: dist_marks!, address: address!, photo: photo, crime: crime, hairStyle: hairStyle, build: build, terrorism: terrorism, complexion: complexion, notes: notes, dateAndTime: currentDateTime)
        
    }
    
    //MARK: Keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fNameField.resignFirstResponder()
        mNameField.resignFirstResponder()
        lNameField.resignFirstResponder()
        aliasField.resignFirstResponder()
        weightField.resignFirstResponder()
        addressField.resignFirstResponder()
        notesField.resignFirstResponder()
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
    
    //MARK: Picker Controls
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if (pickerView == heightPicker){
            return 4
        }
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
        else if (pickerView == hairStylePicker){
            return hairStyle.count
        }
        else if (pickerView == complexionPicker){
            return complexions.count
        }
        else if (pickerView == terrorismPicker){
            return terrorisms.count
        }
        else if (pickerView == buildPicker){
            return builds.count
        }
        else if (pickerView == racePicker){
            return races.count
        }
        else if (pickerView == crimesPicker){
            return crimes.count
        }
        else if (pickerView == weightPicker){
            return weights.count
        }
        else if (pickerView == heightPicker){
            if (component == 0){
                return feetList.count
            }else if (component == 2){
                return inchList.count
            }else {
                return 1
            }
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
        else if (pickerView == hairStylePicker){
            return hairStyle[row]
        }
        else if (pickerView == complexionPicker){
            return complexions[row]
        }
        else if (pickerView == terrorismPicker){
            return terrorisms[row]
        }
        else if (pickerView == buildPicker){
            return builds[row]
        }
        else if (pickerView == racePicker){
            return races[row]
        }
        else if (pickerView == crimesPicker){
            return crimes[row]
        }
        else if (pickerView == weightPicker){
            return "\(weights[row])"
        }
        else if (pickerView == heightPicker){
            if component == 0 {
                return "\(feetList[row])"
            }else if component == 1 {
                return "ft"
            }else if component == 2 {
                return "\(inchList[row])"
            }else {
                return "in"
            }
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
        else if (pickerView == hairStylePicker){
            hairStyleField.text = hairStyle[row]
            hairStyleField.resignFirstResponder()
        }
        else if (pickerView == complexionPicker){
            complexionField.text = complexions[row]
            complexionField.resignFirstResponder()
        }
        else if (pickerView == terrorismPicker){
            terrorismField.text = terrorisms[row]
            terrorismField.resignFirstResponder()
        }
        else if (pickerView == buildPicker){
            buildField.text = builds[row]
            buildField.resignFirstResponder()
        }
        else if (pickerView == racePicker){
            ethnicityField.text = races[row]
            ethnicityField.resignFirstResponder()
        }
        else if (pickerView == crimesPicker){
            crimeField.text = crimes[row]
            crimeField.resignFirstResponder() 
        }
        else if (pickerView == weightPicker){
            weightField.text = "\(weights[row]) lbs"
            weightField.resignFirstResponder()
        }
        else if (pickerView == heightPicker){
            let feetIndex = pickerView.selectedRow(inComponent: 0)
            let inchIndex = pickerView.selectedRow(inComponent: 2)
            heightField.text = "\(feetList[feetIndex])'\(inchList[inchIndex])''"
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
