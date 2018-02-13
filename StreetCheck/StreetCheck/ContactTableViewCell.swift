//
//  ContactTableViewCell.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/11/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    //MARK: Properties
    
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
