//
//  ViewController.swift
//  WeatherMe
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.


import UIKit
import CoreLocation
import SVProgressHUD

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    @IBOutlet weak var zipCodeTextField: UITextField!
    let store = CoordinatesDatastore.sharedInstance
    var userInputLocationSuccess: Bool?
    var coreLocationSuccess: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setDefaultMaskType(.black)
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
        SVProgressHUD.show(withStatus: "Finding Your Location")
        if let userText = self.zipCodeTextField.text{
            GoogleCoordinateAPIClient.isAddressValid(zipCode: userText) { (boolValue) in
                if boolValue == true {
                    self.userInputLocationSuccess = true
                    DispatchQueue.main.async {
                        SVProgressHUD.dismiss()
                        self.presentAlert("Valid Input", message: "Found Forecast", cancelTitle: "OK")
                        self.performSegue(withIdentifier: "goButtonSegue", sender: self)
                    }
                }
                else if boolValue == false {
                    SVProgressHUD.dismiss()
                    self.userInputLocationSuccess = false
                    self.presentAlert("Invalid Input", message: "Please re-enter valid input", cancelTitle: "OK")
                }
            }
        }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
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
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "coreLocationButtonSegue"{
            if self.coreLocationSuccess == true && self.currentLocation != nil {
                return true
            }
        }
        else if identifier == "goButtonSegue"{
            if self.userInputLocationSuccess == true && self.zipCodeTextField.text != nil {
                return true
            }
        }
        return false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        SVProgressHUD.show(withStatus: "Finding your location")
        if self.currentLocation == nil {
            SVProgressHUD.dismiss()
            if let personCoordinates = locations.first{
                self.currentLocation = personCoordinates
                self.coreLocationSuccess = true
                self.presentAlert("Location Found", message: "Your Location was found", cancelTitle: "OK")
                self.performSegue(withIdentifier: "coreLocationButtonSegue", sender: self)
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
        SVProgressHUD.dismiss()
        presentAlert("Location Not Found", message: "Provide zipcode, address or city", cancelTitle: "OK")
        self.shouldPerformSegue(withIdentifier: "coreLocationButton", sender: self)
    }
}
