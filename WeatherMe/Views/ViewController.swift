//
//  ViewController.swift
//  WeatherMe
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.


import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    @IBOutlet weak var zipCodeTextField: UITextField!
    let store = CoordinatesDatastore.sharedInstance
    var userInputLocationSuccess: Bool?
    var coreLocationSuccess: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.zipCodeTextField.text = ""
        self.currentLocation = nil
        self.userInputLocationSuccess = false
        self.coreLocationSuccess = false
    }

    @IBAction func getMyLocationWeatherTapped(_ sender: UIButton) {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestLocation()
    }
    
    
    @IBAction func goButtonTapped(_ sender: Any) {
        if let userText = self.zipCodeTextField.text{
            GoogleCoordinateAPIClient.isAddressValid(zipCode: userText) { (boolValue) in
                if boolValue == true {
                    self.userInputLocationSuccess = true
                    self.performSegue(withIdentifier: "goButtonSegue", sender: self.zipCodeTextField.text)
                }
                else if boolValue == false {
                    self.userInputLocationSuccess = false
                    self.presentAlert("Invalid Input", message: "Please re-enter valid input", cancelTitle: "OK")
                    self.shouldPerformSegue(withIdentifier: "goButtonSegue", sender: sender)
                }
            }
        }
    }
    
    //MARK: What to pass in each of these segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "goButtonSegue"{
            if let destinationVC = segue.destination as? WeatherForecastViewController {
                guard let neededZipcode = self.zipCodeTextField.text else {print("neededZipcode did not unwrap"); return}
                destinationVC.zipCode = neededZipcode
            }
        }
         else if segue.identifier == "coreLocationButtonSegue"{
            if let destinationVC = segue.destination as? WeatherForecastViewController {
            guard let userLocation = currentLocation else {print("did not pass user location"); return}
            destinationVC.coordinateHolder = currentLocation
            }
        }
    }
    
    
    //MARK: Whether the segue should go through
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "locationSegue"{
            if self.coreLocationSuccess == true && self.currentLocation != nil {
                return true
            }
            else if self.userInputLocationSuccess == true && self.zipCodeTextField.text != nil {
                return true
            }
        }
        return false
    }

    
    
    //MARK: CORE LOCATION FUNCTIONS
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.currentLocation == nil {
            if let personCoordinates = locations.first{
                self.currentLocation = personCoordinates
                self.coreLocationSuccess = true
                self.presentAlert("Location Found", message: "Your Location was found", cancelTitle: "OK")
                self.performSegue(withIdentifier: "coreLocationButtonSegue", sender: sender)
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
        self.shouldPerformSegue(withIdentifier: "coreLocationButton", sender: (Any).self)
    }

}

