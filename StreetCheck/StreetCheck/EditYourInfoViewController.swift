//
//  EditYourInfoViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/5/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class EditYourInfoViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = UserDefaults.standard.value(forKey: "name") as? String
        emailField.text = UserDefaults.standard.value(forKey: "email") as? String
        phoneField.text = UserDefaults.standard.value(forKey: "phone") as? String
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateWasPressed(_ sender: UIButton) {
        UserDefaults.standard.set(nameField.text, forKey: "name")
        UserDefaults.standard.set(emailField.text, forKey: "email")
        UserDefaults.standard.set(phoneField.text, forKey: "phone")
    }
    
    
    
}
