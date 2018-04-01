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
    
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        
        photoView.contentMode = .scaleAspectFit

        scrollView.contentSize.height = 1200
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
        view.resignFirstResponder()
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a sources", preferredStyle: .actionSheet)
        
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
