//
//  OnboardingViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/4/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func startWasPressed(_ sender: UIButton) {
        UserDefaults.standard.set(nameField.text, forKey: "name")
        print("I made it here")
        performSegue(withIdentifier: "toPassword", sender: self)
        
    }
    
    @IBAction func skipWasPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "skipToPassword", sender: self)
    }
}
