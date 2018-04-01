//
//  LegalViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 4/1/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class LegalViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleInformation: UITextView!
    @IBOutlet weak var websiteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func websiteButtonWasPressed(_ sender: AnyObject) {
        
        UIApplication.shared.open(URL(string:"https://www.law.cornell.edu/cfr/text/28/part-23")! as URL, options: [:], completionHandler: nil)
        
    }
    
    

}
