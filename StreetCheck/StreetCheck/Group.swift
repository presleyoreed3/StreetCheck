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
    var members: [Contact]?
    var MO: String?
    var crimes: String?
    var leader: Contact?
    var location: String?
    
    init(name: String?, members: [Contact]?, MO: String?, crimes: String?, leader: Contact?, location: String?){
        self.name = name
        self.members = members
        self.MO = MO
        self.crimes = crimes
        self.leader = leader
        self.location = location
        
    }
}
