//
//  ContactEditController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/28/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class ContactEditController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        fNameField.text = contactToEdit?.first_name
        mNameField.text = contactToEdit?.middle_name
        lNameField.text = contactToEdit?.last_name
        
        
    }
   

}
