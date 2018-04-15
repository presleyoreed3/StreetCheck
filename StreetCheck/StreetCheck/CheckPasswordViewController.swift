//
//  CheckPasswordViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/5/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import LocalAuthentication

class CheckPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mismatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = UserDefaults.standard.value(forKey: "name") as? String
        mismatchLabel.text = ""
        passwordField.isSecureTextEntry = true
        // Do any additional setup after loading the view.
        passwordField.delegate = self
    }

    @IBAction func unlockWasPressed(_ sender: UIButton) {
        if (checkPassword()){
            performSegue(withIdentifier: "passwordConfirmed", sender: self)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (checkPassword()){
            passwordField.resignFirstResponder()
            performSegue(withIdentifier: "passwordConfirmed", sender: self)
            return true
        }
        return false
    }
    
    private func checkPassword() -> Bool{
        let password = UserDefaults.standard.value(forKey: "password") as? String
        if (password != passwordField.text) {
            mismatchLabel.text = "Incorrect Password \n Please try again."
            print("The password doesn't match. Should be \((String(describing: password)))")
            print("You entereed: \(String(describing: passwordField.text)) ")
            return false
        }else {
            return true
        }
    }
}
