//
//  GroupsTableViewCell.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/25/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit


class GroupsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupLeaderLabel: UILabel!
    @IBOutlet weak var groupLocationLabel: UILabel!
    @IBOutlet weak var groupImageLabel: UIImageView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
