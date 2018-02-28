//
//  ContactViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 2/16/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log
import MapKit
import CoreLocation

class ContactViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: Declarations
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var f_nameLabel: UILabel!
    @IBOutlet weak var m_nameLabel: UILabel!
    @IBOutlet weak var l_nameLabel: UILabel!
    @IBOutlet weak var alias_label: UILabel!
    @IBOutlet weak var bday_label: UILabel!
    @IBOutlet weak var sex_label: UILabel!
    @IBOutlet weak var wt_label: UILabel!
    @IBOutlet weak var ht_label: UILabel!
    @IBOutlet weak var eye_label: UILabel!
    @IBOutlet weak var hair_label: UILabel!
    @IBOutlet weak var ethnicity_label: UILabel!
    @IBOutlet weak var dis_marksLabel: UITextView!
    @IBOutlet weak var mo_label: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    

    var contactOnDisplay: Contact?
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 1500

        //print(contactOnDisplay)
        // Do any additional setup after loading the view.
        f_nameLabel.text = contactOnDisplay?.first_name
        m_nameLabel.text = contactOnDisplay?.middle_name
        l_nameLabel.text = contactOnDisplay?.last_name
        photoView.image = contactOnDisplay?.photo
        alias_label.text = contactOnDisplay?.alias
        bday_label.text = contactOnDisplay?.birthday
        sex_label.text = contactOnDisplay?.sex
        wt_label.text = contactOnDisplay?.weight
        ht_label.text = contactOnDisplay?.height
        eye_label.text = contactOnDisplay?.eye_color
        hair_label.text = contactOnDisplay?.hair_color
        ethnicity_label.text = contactOnDisplay?.ethnicity
        dis_marksLabel.text = contactOnDisplay?.dis_marks
        dis_marksLabel.isUserInteractionEnabled = false
        mo_label.text = contactOnDisplay?.MO
        mo_label.isUserInteractionEnabled = false
    
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[0]
        
        let center = location.coordinate
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: center , span: span)
        
        mapView.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ContactEditController
        destination?.contactToEdit = contactOnDisplay
    }
}
