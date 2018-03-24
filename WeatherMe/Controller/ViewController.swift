//
//  ViewController.swift
//  WeatherMe

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    @IBOutlet weak var zipCodeTextField: UITextField!
    let store = WeatherForecastLocationDatastore.sharedInstance
    var isCoreLocationEnabled: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func findMyLocationButtonTapped(_ sender: Any) {
        print("this button was pressed")
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestLocation()
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
                print("LOOK HERE FOR COORDINATES")
                print(personCoordinates.coordinate.latitude)
                print(personCoordinates.coordinate.longitude)
                print("LOOK HERE FOR COORDINATES")
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
    
//extension ViewController : CLLocationManagerDelegate {

//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//            if self.currentLocation == nil {
//                if let personCoordinates = locations.first{
//                    self.currentLocation = personCoordinates
//                    print("LOOK HERE FOR COORDINATES")
//                    print(personCoordinates.coordinate.latitude)
//                    print(personCoordinates.coordinate.longitude)
//                    print("LOOK HERE FOR COORDINATES")
//                }
//            }
//        }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            self.locationManager?.startUpdatingLocation()
//        }
//        else if status == .notDetermined || status == .denied || status == .restricted {
//            self.locationManager?.requestWhenInUseAuthorization()
//            }
//        }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("core location did not work")
//    }
//}

//==========================
////
////  ViewController.swift
////  WeatherMe
//
//import UIKit
//import CoreLocation
//
//class ViewController: UIViewController{
//
//    var locationManager: CLLocationManager?
//    var currentLocation: CLLocation?
//    @IBOutlet weak var zipCodeTextField: UITextField!
//    let store = WeatherForecastLocationDatastore.sharedInstance
//    var isCoreLocationEnabled: Bool?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("*************************")
//        self.locationManager = CLLocationManager()
//        self.locationManager?.delegate = self
//        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        self.locationManager?.requestWhenInUseAuthorization()
//        self.locationManager?.requestLocation()
//        self.locationManager?.startUpdatingLocation()
//        print("*************************")
//    }
//    @IBAction func findMyLocationButtonTapped(_ sender: Any) {
//        print("this button was pressed")
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "weatherSegue" {
//            if let destinationVC = segue.destination as? WeatherForecastViewController {
//                if self.currentLocation != nil {
//                    guard let latestCoordinates = self.currentLocation else {print("latestCoordinates did not unwrap"); return}
//                    destinationVC.coordinateHolder = latestCoordinates
//                }
//                else if self.zipCodeTextField.text != nil{
//                    guard let neededZipcode = self.zipCodeTextField.text else {print("neededZipcode did not unwrap"); return}
//                    destinationVC.zipCode = neededZipcode
//                }
//            }
//        }
//    }
//}
//
//extension ViewController : CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if self.currentLocation == nil {
//            if let personCoordinates = locations.first{
//                self.currentLocation = personCoordinates
//                print("LOOK HERE FOR COORDINATES")
//                print(personCoordinates.coordinate.latitude)
//                print(personCoordinates.coordinate.longitude)
//                print("LOOK HERE FOR COORDINATES")
//            }
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if status == .authorizedWhenInUse {
//            self.locationManager?.startUpdatingLocation()
//        }
//        else if status == .notDetermined || status == .denied || status == .restricted {
//            self.locationManager?.requestWhenInUseAuthorization()
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("core location did not work")
//    }
//}
//
//

