//
//  Contact.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/2/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log

class Contact: NSObject, NSCoding{
    
    //MARK: Properties
    var first_name: String
    var middle_name: String?
    var last_name: String
    var alias: String?
    var photo: UIImage?
    var sex: String?
    var birthday: String
    var hair_color: String?
    var eye_color: String?
    var height: String?
    var weight: String?
    var ethnicity: String?
    var dis_marks: String?
    var MO: String?
    var address: String?
    var time_left: Int?
    var crime: String?
    
    
    //MARK: Initializer
    init?(first_name: String, middle_name: String?, last_name: String, alias: String?, birthday: String, MO: String?, height: String?, weight: String?, hair_color: String?, eye_color: String?, sex: String?, ethnicity: String?, dis_marks: String?, address: String?, photo: UIImage?, crime: String?) {
        self.first_name = first_name
        self.middle_name = middle_name
        self.last_name = last_name
        self.alias = alias
        self.birthday = birthday
        self.MO = MO
        self.height = height
        self.weight = weight
        self.hair_color = hair_color
        self.eye_color = eye_color
        self.sex = sex
        self.ethnicity = ethnicity
        self.dis_marks = dis_marks
        self.address = address
        self.photo = photo
        self.crime = crime
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(first_name, forKey: PropertyKey.first_name)
        aCoder.encode(middle_name, forKey: PropertyKey.middle_name)
        aCoder.encode(last_name, forKey: PropertyKey.last_name)
        aCoder.encode(alias, forKey: PropertyKey.alias)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(sex, forKey: PropertyKey.sex)
        aCoder.encode(birthday, forKey: PropertyKey.birthday)
        aCoder.encode(hair_color, forKey: PropertyKey.hair_color)
        aCoder.encode(eye_color, forKey: PropertyKey.eye_color)
        aCoder.encode(height, forKey: PropertyKey.height)
        aCoder.encode(weight, forKey: PropertyKey.weight)
        aCoder.encode(ethnicity, forKey: PropertyKey.ethnicity)
        aCoder.encode(dis_marks, forKey: PropertyKey.dis_marks)
        aCoder.encode(MO, forKey: PropertyKey.MO)
        aCoder.encode(address, forKey: PropertyKey.address)
        aCoder.encode(crime, forKey: PropertyKey.crime)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let first_name = aDecoder.decodeObject(forKey: PropertyKey.first_name) as? String
        let middle_name = aDecoder.decodeObject(forKey: PropertyKey.middle_name) as? String
        let last_name = aDecoder.decodeObject(forKey: PropertyKey.last_name) as? String
        let alias = aDecoder.decodeObject(forKey: PropertyKey.alias) as? String
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let sex = aDecoder.decodeObject(forKey: PropertyKey.sex) as? String
        let birthday = aDecoder.decodeObject(forKey: PropertyKey.birthday) as? String
        let hair_color = aDecoder.decodeObject(forKey: PropertyKey.hair_color) as? String
        let eye_color = aDecoder.decodeObject(forKey: PropertyKey.eye_color) as? String
        let height = aDecoder.decodeObject(forKey: PropertyKey.height) as? String
        let weight = aDecoder.decodeObject(forKey: PropertyKey.weight) as? String
        let ethnicity = aDecoder.decodeObject(forKey: PropertyKey.ethnicity) as? String
        let dis_marks = aDecoder.decodeObject(forKey: PropertyKey.dis_marks) as? String
        let MO = aDecoder.decodeObject(forKey: PropertyKey.MO) as? String
        let address = aDecoder.decodeObject(forKey: PropertyKey.address) as? String
        let crime = aDecoder.decodeObject(forKey: PropertyKey.crime) as? String
        
        self.init(first_name: first_name!, middle_name: middle_name, last_name: last_name!, alias: alias, birthday: birthday!, MO: MO, height: height, weight: weight, hair_color: hair_color, eye_color: eye_color,  sex: sex, ethnicity: ethnicity, dis_marks: dis_marks, address: address, photo: photo, crime: crime)
        
    }
    
    //MARK:Struct
    struct PropertyKey{
        static let first_name = "first_name"
        static let middle_name = "middle_name"
        static let last_name = "last_name"
        static let alias = "alias"
        static let photo =  "photo"
        static let sex = "sex"
        static let birthday = "birthday"
        static let hair_color = "hair_color"
        static let eye_color = "eye_color"
        static let height = "height"
        static let weight = "weight"
        static let ethnicity = "ethnicity"
        static let dis_marks = "dis_marks"
        static let MO = "MO"
        static let address = "address"
        static let crime = "crime"
    }
    
    //MARK: Archiving Paths
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("contacts")
    
}
