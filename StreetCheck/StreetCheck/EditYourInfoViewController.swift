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
    @IBOutlet weak var mismatchLabel: UILabel!
    @IBOutlet weak var idField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.text = UserDefaults.standard.value(forKey: "name") as? String
        idField.text = UserDefaults.standard.value(forKey: "id") as? String
        mismatchLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateWasPressed(_ sender: UIButton) {
        UserDefaults.standard.set(nameField.text, forKey: "name")
        UserDefaults.standard.set(idField.text, forKey: "id")
        mismatchLabel.text = "Your information has been updated"
    }
    
    
    
}
