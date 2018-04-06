//
//  OnboardingViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/4/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var tellUsMoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        emailField.delegate = self
        phoneField.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
    }
    
//    deinit {
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
//    }

    @IBAction func startWasPressed(_ sender: UIButton) {
        if (nameField.text != "" || emailField.text != "" || phoneField.text != ""){
            UserDefaults.standard.set(nameField.text, forKey: "name")
            UserDefaults.standard.set(emailField.text, forKey: "email")
            UserDefaults.standard.set(phoneField.text, forKey: "phone")
            performSegue(withIdentifier: "toPassword", sender: self)
        }else{
            tellUsMoreLabel.text = "Please fill out all of the fields"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailField.resignFirstResponder()
        performSegue(withIdentifier: "toPassword", sender: self)
        return true
    }
    
    @IBAction func skipWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toPassword", sender: self)
    }
    
}
