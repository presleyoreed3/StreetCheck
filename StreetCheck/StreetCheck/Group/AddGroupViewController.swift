//
//  AddGroupViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/25/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log


class AddGroupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var addPhoto: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupLeader: UITextField!
    @IBOutlet weak var groupLocation: UITextField!
    @IBOutlet weak var groupMembers: UITextView!
    @IBOutlet weak var groupOffenses: UITextView!
    @IBOutlet weak var groupMO: UITextView!
    @IBOutlet weak var crimeField: UITextField!
    @IBOutlet weak var terrorismField: UITextField!
    @IBOutlet weak var classField: UITextField!
    
    var crimePicker = UIPickerView()
    var classPicker = UIPickerView()
    var terrorismPicker = UIPickerView()
    
    let crimes = ["Homicide", "Rape", "Robbery", "Assault", "Burglary", "Theft", "Arson", "Kidnapping", "Forgary/Fraud", "Vandalism", "Weapons", "Prostitution", "Gambling", "DUI", "Harassment"]
    let terrorisms = ["Domestic Terrorism", "International Terrorism", "Hate Crimes", "Race Supremacy", "Environmental Extremists", "Animal Rights Extremists", "Anarchist Extremists", "Anti-abortion Extremists", "Lone Wolf Extremist", "Religious Extremists", "Sovereign Citizen Extremists", "Militia Extremists", "N/A"]
    let classifications = ["Criminal Enterprise", "Street Gang", "Outlaw Motorcycle Gang", "Terrorist Group"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 1550
        // Do any additional setup after loading the view.
        
        crimePicker.delegate = self
        crimePicker.dataSource = self
        crimeField.inputView = crimePicker
        
        classPicker.delegate = self
        classPicker.dataSource = self
        classField.inputView = classPicker
        
        terrorismPicker.delegate = self
        terrorismPicker.dataSource = self
        terrorismField.inputView = terrorismPicker
        
        groupMembers.placeholder = "Members of the Group"
        groupOffenses.placeholder = "Crimes commited by Group"
        groupMO.placeholder = "Group MO"
    }
    
    

    var group: Group?
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var saveButton: UIBarButtonItem!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        resignFirstResponder()
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = groupName?.text
        let leader = groupLeader?.text
        let members = groupMembers?.text
        let location = groupLocation?.text
        let crimes = groupOffenses?.text
        let mo = groupMO?.text
        let groupImage = photo?.image
        let crime = crimeField?.text
        let terrorism = terrorismField?.text
        let classification = classField?.text
        
        group = Group(name: name, members: members, MO: mo, crimes: crimes, leader: leader, location: location, image: groupImage, crime: crime, terrorism: terrorism, classification: classification)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == crimePicker){
            return crimes.count
        }
        else if (pickerView == classPicker){
            return classifications.count
        }
        else if (pickerView == terrorismPicker){
            return terrorisms.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == crimePicker){
            return crimes[row]
        }
        else if (pickerView == classPicker){
            return classifications[row]
        }
        else if (pickerView == terrorismPicker){
            return terrorisms[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == crimePicker){
            crimeField.text = crimes[row]
            crimeField.resignFirstResponder()
        }
        else if (pickerView == classPicker){
            classField.text = classifications[row]
            classField.resignFirstResponder()
        }
        else if (pickerView == terrorismPicker){
            terrorismField.text = terrorisms[row]
            terrorismField.resignFirstResponder()
        }
    }
    
    //MARK: Add Photo
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
        photo.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}
