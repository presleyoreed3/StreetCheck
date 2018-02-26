//
//  Contact.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/2/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit

class Contact{
    
    //MARK: Global CID Counter
    
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
    
    
    //MARK: Initializer
    init(first_name: String, middle_name: String?, last_name: String, alias: String?, birthday: String, MO: String?, height: String?, weight: String?, hair_color: String?, eye_color: String?, sex: String?, ethnicity: String?, dis_marks: String?, address: String?, time_left: Int?, photo: UIImage?) {
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
        self.time_left = time_left
        self.photo = photo
    }
    
}
