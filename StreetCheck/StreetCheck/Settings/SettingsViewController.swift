//
//  SettingsViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/1/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import LocalAuthentication

class SettingsViewController: UIViewController {
    @IBOutlet weak var moreInfoButton: UIButton!
    @IBOutlet weak var bio_label: UILabel!
    @IBOutlet weak var bio_toggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (UserDefaults.standard.value(forKey: "biometrics") as? Bool == true){
            bio_toggle.isOn = true
        }else{
            bio_toggle.isOn = false
        }
        
//        if (bioType.rawValue == 0){
//            bio_label.text = ""
//            bio_toggle.isHidden = true
//        }else if (bioType.rawValue == 1){
//            bio_label.text = "Enable Touch ID"
//            bio_toggle.isHidden = false
//        }else if (bioType.rawValue == 2){
//            bio_label.text = "Enable Face ID"
//            bio_toggle.isHidden = false
//        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func bio_toggled(_ sender: UISwitch) {
        if bio_toggle.isOn{
            UserDefaults.standard.set(true, forKey: "biometrics")
        }else{
            UserDefaults.standard.set(false, forKey: "biometrics")
        }
    }
    
    
}
