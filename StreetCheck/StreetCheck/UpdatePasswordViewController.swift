//
//  UpdatePasswordViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/5/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currentPasswordField: UITextField!
    @IBOutlet weak var newPasswordOneField: UITextField!
    @IBOutlet weak var newPasswordTwoField: UITextField!
    @IBOutlet weak var mismatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentPasswordField.isSecureTextEntry = true
        newPasswordOneField.isSecureTextEntry = true
        newPasswordTwoField.isSecureTextEntry = true
        
        mismatchLabel.text = " "

    }

    @IBAction func updateWasPressed(_ sender: UIButton) {
        
        if (currentPasswordField.text == UserDefaults.standard.value(forKey: "password") as? String){
            if (checkPasswords()){
                UserDefaults.standard.set(newPasswordOneField.text, forKey: "password")
            }
        }
        
    }
    
    func checkPasswords() -> Bool{
        if (newPasswordOneField.text != newPasswordTwoField.text ){
            mismatchLabel.text = "Your passwords do not match. \n Plase try again."
            return false
        }else if(newPasswordOneField.text == "" || newPasswordTwoField.text == ""){
            mismatchLabel.text = "Please enter a password"
            return false
        }
        else{
            mismatchLabel.text = "Your password has been updated"
            return true
        }
    }
    
}
