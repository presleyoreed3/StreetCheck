//
//  SetPasswordViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/4/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class SetPasswordViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordOne: UITextField!
    @IBOutlet weak var passwordTwo: UITextField!
    @IBOutlet weak var finishedButton: UIButton!
    @IBOutlet weak var mismatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordOne.isSecureTextEntry = true
        passwordTwo.isSecureTextEntry = true
        
        mismatchLabel.text = " "
        let name = UserDefaults.standard.value(forKey: "name")
        if ("\(String(describing: name))" == ""){
            nameLabel.text = ""
        }else {
            nameLabel.text = ""
        }
        
    }

    @IBAction func finishedWasPressed(_ sender: UIButton) {
        checkPasswords()
        UserDefaults.standard.set(passwordOne.text, forKey: "password")
        if (mismatchLabel.text == "" && passwordOne.text != ""){
            performSegue(withIdentifier: "toHomePage", sender: self)
        }
    }
    
    func checkPasswords(){
        if (passwordOne.text != passwordTwo.text ){
            mismatchLabel.text = "Your passwords do not match. \n Plase try again."
        }else if(passwordOne.text == "" || passwordTwo.text == ""){
            mismatchLabel.text = "Please enter a password"
        }
        else{
            mismatchLabel.text = ""
        }
    }
    
}
