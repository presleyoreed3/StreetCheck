//
//  crimeLocationPin.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/6/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import MapKit

class CrimeLocationPin : NSObject, MKAnnotation{
    var crime: String?
    var location: String?
    var coordinate: CLLocationCoordinate2D
    
    init(crime: String, location: String, coordinate: CLLocationCoordinate2D){
        self.crime = crime
        self.location = location
        self.coordinate = coordinate
    }
}
