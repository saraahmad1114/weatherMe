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
    var isCoreLocationEnabled: Bool?
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
        if self.currentLocation?.coordinate.latitude == nil && self.currentLocation?.coordinate.longitude == nil{
            presentAlert("Unsuccessful Getting Your Coodinates", message: "Please enter a valid address, city or zipcode in the textfield.", cancelTitle: "OK")
        }
    }
    
    @IBAction func getMyWeatherOtherTapped(_ sender: UIButton) {
        if self.zipCodeTextField.text == nil {
            presentAlert("Error", message: "Please enter valid information in text box.", cancelTitle: "OK")
        } else {
            do {
                try self.store.getUserCoordintes(zipcode: self.zipCodeTextField.text!, completion: { (userCoodinates) in
                print(userCoodinates)
                self.presentAlert("Error", message: "Provide valid address, zipcode, or city", cancelTitle: "OK")
                })
            }
            catch let error{
                print("This is the error \(error.localizedDescription)")
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "weatherSegue" {
            if let destinationVC = segue.destination as? WeatherForecastViewController {
                if self.currentLocation != nil {
                    guard let latestCoordinates = self.currentLocation else {print("latestCoordinates did not unwrap"); return}
                    destinationVC.coordinateHolder = latestCoordinates
                }
                else if self.zipCodeTextField.text != nil{
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
                print(personCoordinates.coordinate.latitude)
                print(personCoordinates.coordinate.longitude)
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
        print("core location did not work: \(error)")
    }
}

