//
//  GroupViewController.swift
//  StreetCheck
//
//  Created by Presley Reed III on 3/28/18.
//  Copyright © 2018 Presley Reed III. All rights reserved.
//

import UIKit
import os.log
import MapKit
import CoreLocation

class GroupViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var leaderLabel: UILabel!
    @IBOutlet weak var memberLabel: UITextView!
    @IBOutlet weak var moLabel: UITextView!
    @IBOutlet weak var addressLabel: UITextView!
    @IBOutlet weak var photoLabel: UIImageView!
    @IBOutlet weak var crimeLabel: UITextView!
    
    @IBOutlet weak var mapView: MKMapView!
    
    var groupOnDisplay: Group?
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateData()
        scrollView.contentSize.height = 1815
        // Do any additional setup after loading the view.
    }

    func updateData(){
        nameLabel.text = groupOnDisplay?.name
        leaderLabel.text = groupOnDisplay?.leader
        memberLabel.text = groupOnDisplay?.members
        memberLabel.isUserInteractionEnabled = false
        photoLabel.image = groupOnDisplay?.image
        photoLabel.isUserInteractionEnabled = true
        moLabel.text = groupOnDisplay?.MO
        moLabel.isUserInteractionEnabled = false
        addressLabel.text = groupOnDisplay?.location
        addressLabel.isUserInteractionEnabled = false
        crimeLabel.text = groupOnDisplay?.crimes
        
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
                print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
                let lat = coordinates.latitude
                let long = coordinates.longitude
                let location = CLLocationCoordinate2DMake(lat, long)
                self.mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 1500, 1500), animated: true)
                
                
                let pin = CrimeLocationPin(crime: self.nameLabel.text!, location: address!, coordinate: location)
                
                self.mapView.addAnnotation(pin)
            }
        })
    }
    
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
}