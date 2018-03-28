//
//  Group.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/25/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class Group {
    
    var name: String?
    var members: String?
    var MO: String?
    var crimes: String?
    var leader: String?
    var location: String?
    var image: UIImage?
    
    init(name: String?, members: String?, MO: String?, crimes: String?, leader: String?, location: String?, image: UIImage?){
        self.name = name
        self.members = members
        self.MO = MO
        self.crimes = crimes
        self.leader = leader
        self.location = location
        self.image = image
        
    }
}
