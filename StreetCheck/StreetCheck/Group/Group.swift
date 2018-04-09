//
//  Group.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/25/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class Group: NSObject, NSCoding {
    
    var name: String?
    var members: String?
    var MO: String?
    var crimes: String?
    var leader: String?
    var location: String?
    var image: UIImage?
    var crime: String?
    var terrorism: String?
    var classification: String?
    
    init?(name: String?, members: String?, MO: String?, crimes: String?, leader: String?, location: String?, image: UIImage?, crime: String?, terrorism: String?, classification: String?){
        self.name = name
        self.members = members
        self.MO = MO
        self.crimes = crimes
        self.leader = leader
        self.location = location
        self.image = image
        self.crime = crime
        self.terrorism = terrorism
        self.classification = classification
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(members, forKey: PropertyKey.members)
        aCoder.encode(MO, forKey: PropertyKey.MO)
        aCoder.encode(crimes, forKey: PropertyKey.crimes)
        aCoder.encode(leader, forKey: PropertyKey.leader)
        aCoder.encode(location, forKey: PropertyKey.location)
        aCoder.encode(image, forKey: PropertyKey.image)
        aCoder.encode(crime, forKey: PropertyKey.crime)
        aCoder.encode(terrorism, forKey: PropertyKey.terrorism)
        aCoder.encode(classification, forKey: PropertyKey.classification)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String
        let members = aDecoder.decodeObject(forKey: PropertyKey.members) as? String
        let MO = aDecoder.decodeObject(forKey: PropertyKey.MO) as? String
        let crimes = aDecoder.decodeObject(forKey: PropertyKey.crimes) as? String
        let leader = aDecoder.decodeObject(forKey: PropertyKey.leader) as? String
        let location = aDecoder.decodeObject(forKey: PropertyKey.location) as? String
        let image = aDecoder.decodeObject(forKey: PropertyKey.image) as? UIImage
        let crime = aDecoder.decodeObject(forKey: PropertyKey.crime) as? String
        let terrorism = aDecoder.decodeObject(forKey: PropertyKey.terrorism) as? String
        let classification = aDecoder.decodeObject(forKey: PropertyKey.classification) as? String
        
        self.init(name: name, members: members, MO: MO, crimes: crimes, leader: leader, location: location, image: image, crime: crime, terrorism: terrorism, classification: classification)
        
    }
    
    struct PropertyKey{
        static let name = "name"
        static let members = "members"
        static let MO = "MO"
        static let crimes = "crimes"
        static let leader = "leader"
        static let location = "location"
        static let image = "image"
        static let crime = "crime"
        static let terrorism = "terrorism"
        static let classification = "classification"
    }
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("groups")
}
