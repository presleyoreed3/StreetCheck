//
//  EditGroupViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/29/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

class EditGroupViewController: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDelegate,  UINavigationControllerDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var groupToEdit: Group?
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var groupNameLabel: UITextField!
    @IBOutlet weak var groupLeaderLabel: UITextField!
    @IBOutlet weak var groupMemberLabel: UITextView!
    @IBOutlet weak var groupLocationLabel: UITextField!
    @IBOutlet weak var groupMOLabel: UITextView!
    @IBOutlet weak var groupCrimesLabel: UITextView!
    @IBOutlet weak var crimeField: UITextField!
    @IBOutlet weak var terrorismField: UITextField!
    @IBOutlet weak var classField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var crimePicker = UIPickerView()
    var terrorismPicker = UIPickerView()
    var classPicker = UIPickerView()
    
    let crimes = ["","Homicide", "Rape", "Robbery", "Assault", "Burglary", "Theft", "Arson", "Kidnapping", "Forgary/Fraud", "Vandalism", "Weapons", "Prostitution", "Gambling", "DUI", "Harassment"]
    let terrorisms = ["","Domestic Terrorism", "International Terrorism", "Hate Crimes", "Race Supremacy", "Environmental Extremists", "Animal Rights Extremists", "Anarchist Extremists", "Anti-abortion Extremists", "Lone Wolf Extremist", "Religious Extremists", "Sovereign Citizen Extremists", "Militia Extremists", "N/A"]
    let classifications = ["","criminal enterprise", "street gang", "outlaw motorcycle gang", "terrorist group"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupNameLabel.delegate = self
        groupLeaderLabel.delegate = self
        groupLocationLabel.delegate = self
        
        photoView.image = groupToEdit?.image
        groupNameLabel.text = groupToEdit?.name
        groupLeaderLabel.text = groupToEdit?.leader
        groupCrimesLabel.text = groupToEdit?.crimes
        groupMOLabel.text = groupToEdit?.MO
        groupLocationLabel.text = groupToEdit?.location
        groupMemberLabel.text = groupToEdit?.members
        crimeField.text = groupToEdit?.crime
        terrorismField.text = groupToEdit?.terrorism
        classField.text = groupToEdit?.classification
        
        
        crimePicker.delegate = self
        crimePicker.dataSource = self
        crimeField.inputView = crimePicker
        
        terrorismPicker.delegate = self
        terrorismPicker.dataSource = self
        terrorismField.inputView = terrorismPicker
        
        classPicker.delegate = self
        classPicker.dataSource = self
        classField.inputView = classPicker
        
        groupMemberLabel.placeholder = "Members of the Group"
        groupCrimesLabel.placeholder = "Crimes commited by Group"
        groupMOLabel.placeholder = "Group MO"
        
        photoView.contentMode = .scaleAspectFit

        scrollView.contentSize.height = 1200
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        groupNameLabel.resignFirstResponder()
        groupLocationLabel.resignFirstResponder()
        groupLeaderLabel.resignFirstResponder()
        return true
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
     
        let name = groupNameLabel?.text
        let leader = groupLeaderLabel?.text
        let members = groupMemberLabel?.text
        let address = groupLocationLabel?.text
        let mo = groupMOLabel?.text
        let crimes = groupCrimesLabel?.text
        let photo = photoView?.image
        let crime = crimeField?.text
        let terrorism = terrorismField?.text
        let classification = classField?.text
        
        let currentDate = Date()
        
        
        groupToEdit = Group(name: name, members: members, MO: mo, crimes: crimes, leader: leader, location: address, image: photo, crime: crime, terrorism: terrorism, classification: classification, dateAndTime: currentDate)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == crimePicker){
            return crimes.count
        }
        else if (pickerView == terrorismPicker){
            return terrorisms.count
        }
        else if (pickerView == classPicker){
            return classifications.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == crimePicker){
            return crimes[row]
        }
        else if (pickerView == terrorismPicker){
            return terrorisms[row]
        }
        else if (pickerView == classPicker){
            return classifications[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == crimePicker){
            crimeField.text = crimes[row]
            crimeField.resignFirstResponder()
        }
        else if (pickerView == terrorismPicker){
            terrorismField.text = terrorisms[row]
            terrorismField.resignFirstResponder()
        }
        else if (pickerView == classPicker){
            classField.text = classifications[row]
            classField.resignFirstResponder()
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
        photoView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}
