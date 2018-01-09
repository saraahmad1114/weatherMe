//
//  ViewController.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
//    let locationManager = CLLocationManager()
//    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startMonitoringSignificantLocationChanges()
    }
    
//    func locationAuthStatus() {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
//            self.currentLocation = self.locationManager.location
//        } else {
//            self.locationManager.requestWhenInUseAuthorization()
//            locationAuthStatus()
//        }
//
//    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}


