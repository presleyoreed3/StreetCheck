//
//  CheckPasswordViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/5/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class CheckPasswordViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var mismatchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = UserDefaults.standard.value(forKey: "name") as? String
        // Do any additional setup after loading the view.
    }

    @IBAction func unlockWasPressed(_ sender: UIButton) {
        let password = UserDefaults.standard.value(forKey: "password")
        if ((String(describing: password)) != passwordField.text) {
            mismatchLabel.text = "Incorrect Password \n Please try again."
        }else {
            performSegue(withIdentifier: "passwordConfirmed", sender: self)
        }
    }
    
}
