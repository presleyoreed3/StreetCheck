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
    @IBOutlet weak var tellUsMoreLabel: UILabel!
    @IBOutlet weak var idField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        idField.delegate = self
    }

    @IBAction func startWasPressed(_ sender: UIButton) {
        if (nameField.text != "" || idField.text != ""){
            UserDefaults.standard.set(nameField.text, forKey: "name")
            UserDefaults.standard.set(idField.text, forKey: "id")
            performSegue(withIdentifier: "toPassword", sender: self)
        }else{
            tellUsMoreLabel.text = "Please fill out all of the fields"
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        UserDefaults.standard.set(nameField.text, forKey: "name")
        UserDefaults.standard.set(idField.text, forKey: "id")
        nameField.resignFirstResponder()
        idField.resignFirstResponder()
        performSegue(withIdentifier: "toPassword", sender: self)
        return true
    }
    
    @IBAction func skipWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toPassword", sender: self)
    }
    
}
