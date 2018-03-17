//
//  ViewController.swift
//  WeatherMe

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    
//MAY USE THIS LATER -- KEEP THIS FOR NOW!!!!
//    func isZipCodeValid(text: String) -> Bool {
//        let zipCodeTestPredicate = NSPredicate (format:"SELF MATCHES %@","(^[0-9]{5}(-[0-9]{4})?$)")
//        return zipCodeTestPredicate.evaluate(with: zipCodeTextField.text)
//    }
    
    
    @IBAction func findMyLocationButtonTapped(_ sender: Any) {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self as? CLLocationManagerDelegate
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "weatherSegue" {
        if let destinationVC = segue.destination as? CurrentWeatherViewController2{
            if self.currentLocation != nil {
                guard let latestCoordinates = self.currentLocation else {print("latestCoordinates did not unwrap"); return}
                destinationVC.coordinateHolder = self.currentLocation
            }
            else if self.zipCodeTextField.text != nil{
                guard let neededZipcode = self.zipCodeTextField.text else {print("neededZipcode did not unwrap"); return}
                destinationVC.zipCode = neededZipcode
                    }
                }
            }
        }
    }
    
    extension ViewController: CLLocationManagerDelegate{
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if self.currentLocation == nil {
            self.currentLocation = locations.first!
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
    }


