//
//  EditGroupViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/29/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

class EditGroupViewController: UIViewController, UIImagePickerControllerDelegate, UIPickerViewDelegate,  UINavigationControllerDelegate {
    
    var groupToEdit: Group?
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var groupNameLabel: UITextField!
    @IBOutlet weak var groupLeaderLabel: UITextField!
    @IBOutlet weak var groupMemberLabel: UITextView!
    @IBOutlet weak var groupLocationLabel: UITextField!
    @IBOutlet weak var groupMOLabel: UITextView!
    @IBOutlet weak var groupCrimesLabel: UITextView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        photoView.image = groupToEdit?.image
        groupNameLabel.text = groupToEdit?.name
        groupLeaderLabel.text = groupToEdit?.leader
        groupCrimesLabel.text = groupToEdit?.crimes
        groupMOLabel.text = groupToEdit?.MO
        groupLocationLabel.text = groupToEdit?.location
        groupMemberLabel.text = groupToEdit?.members
        
        groupMemberLabel.placeholder = "Members of the Group:"
        groupCrimesLabel.placeholder = "Offenses commited by Group:"
        groupMOLabel.placeholder = "Group MO:"

        
        // Do any additional setup after loading the view.
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
        
        
        groupToEdit = Group(name: name, members: members, MO: mo, crimes: crimes, leader: leader, location: address, image: photo)
        
    }
    
    //MARK: Image
    @IBAction func addPhotoButton(_ sender: UIButton) {
        //Resigns keyboard
        resignFirstResponder()
        
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
        photoView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
}
