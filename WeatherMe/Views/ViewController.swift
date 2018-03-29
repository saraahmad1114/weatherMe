//
//  ViewController.swift
//  WeatherMe
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    var userCurrentLat: Double?
    var userCurrentLng: Double?
    @IBOutlet weak var zipCodeTextField: UITextField!
    let store = CoordinatesDatastore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func getMyLocationWeatherTapped(_ sender: UIButton) {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestLocation()
        presentAlert("Location Found", message: "Press Go Button", cancelTitle: "OK")
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSeg" {
            if let destinationVC = segue.destination as? WeatherForecastViewController {
                if self.userCurrentLng != nil && self.userCurrentLat != nil {
                    guard let neededLat = self.userCurrentLat else {print("neededLat did not unwrap"); return}
                    guard let neededLng = self.userCurrentLng else {print("neededLng did not unwrap"); return}
                    destinationVC.currentLat = neededLat
                    destinationVC.currentLng = neededLng
                }
                else if self.zipCodeTextField != nil{
                    guard let neededZipcode = self.zipCodeTextField.text else {print("neededZipcode did not unwrap"); return}
                    destinationVC.zipCode = neededZipcode
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.currentLocation == nil {
            if let personCoordinates = locations.first{
                self.userCurrentLat = personCoordinates.coordinate.latitude
                self.userCurrentLng = personCoordinates.coordinate.longitude
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.locationManager?.startUpdatingLocation()
        }
        else if status == .notDetermined || status == .denied || status == .restricted {
            self.locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        presentAlert("Location Not Found", message: "Provide zipcode, address or city", cancelTitle: "OK")
    }
}

