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
    @IBOutlet weak var zipCodeTextField: UITextField!
    let store = CoordinatesDatastore.sharedInstance
    var locationSuccess: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.zipCodeTextField.text = ""
        self.currentLocation = nil
        self.locationSuccess = false
    }

    @IBAction func getMyLocationWeatherTapped(_ sender: UIButton) {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSeg" {
            if let destinationVC = segue.destination as? WeatherForecastViewController {
                
                
                if self.currentLocation != nil {
                    guard let userLocation = currentLocation else {print("did not pass user location"); return}
                    destinationVC.coordinateHolder = currentLocation
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
                self.currentLocation = personCoordinates
                if self.currentLocation != nil {
                    presentAlert("Location Found", message: "We have found your location", cancelTitle: "OK")
                }
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

