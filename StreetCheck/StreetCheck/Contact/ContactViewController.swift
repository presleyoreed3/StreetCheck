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
    @IBOutlet weak var crimeLabel: UITextView!
    @IBOutlet weak var addressLabel: UITextView!
    

    var contactOnDisplay: Contact?
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize.height = 2350
        

        //print(contactOnDisplay)
        // Do any additional setup after loading the view.
        updateData()
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        
        
        
    }
    
    func updateData(){
        f_nameLabel.text = contactOnDisplay?.first_name
        m_nameLabel.text = contactOnDisplay?.middle_name
        l_nameLabel.text = contactOnDisplay?.last_name
        photoView.image = contactOnDisplay?.photo
        photoView.isUserInteractionEnabled = true
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
        crimeLabel.text = contactOnDisplay?.crime
        addressLabel.text = contactOnDisplay?.address
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let address = addressLabel.text
        
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address!, completionHandler: {(placemarks, error) -> Void in
            if((error) != nil){
                print("Error", error ?? "")
            }
            if let placemark = placemarks?.first {
                let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                let lat = coordinates.latitude
                let long = coordinates.longitude
                let location = CLLocationCoordinate2DMake(lat, long)
                self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 1500, 1500), animated: true)
                
                
                let pin = CrimeLocationPin(crime: self.crimeLabel.text!, location: address!, coordinate: location)
                
                self.mapView.addAnnotation(pin)
            }
        })
        
        
    }
    
    //MARK: Action
   
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        let newImageView = UIImageView(image: imageView.image)
        newImageView.frame = UIScreen.main.bounds
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        sender.view?.removeFromSuperview()
    }
    
    // MARK: Navigation
    
//    @IBAction func didSelectEdit(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "editContact", sender: self)
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? ContactEditController
        destination?.contactToEdit = contactOnDisplay
    }
    
    @IBAction func unwindToContactView(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ContactEditController, let contact = sourceViewController.contactToEdit {
            print(contact.first_name)
            contactOnDisplay = contact
            updateData()
            
        }
    }
}
