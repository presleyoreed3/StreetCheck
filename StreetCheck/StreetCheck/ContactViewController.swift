//
//  ContactViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/16/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    //MARK: Declarations
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var f_nameLabel: UILabel!
    @IBOutlet weak var m_nameLabel: UILabel!
    @IBOutlet weak var l_nameLabel: UILabel!
    
    var contactOnDisplay: Contact?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(contactOnDisplay)
        // Do any additional setup after loading the view.
        f_nameLabel.text = contactOnDisplay?.first_name
        m_nameLabel.text = contactOnDisplay?.middle_name
        l_nameLabel.text = contactOnDisplay?.last_name
        photoView.image = contactOnDisplay?.photo
    }
    
    // MARK: Navigation
    @IBAction func closeDetailView(_ sender: UIBarButtonItem) {
        print("I was pressed")
        dismiss(animated: true, completion: nil)
    }
    
    
    
}
