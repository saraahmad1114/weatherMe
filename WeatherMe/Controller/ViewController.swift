//
//  ViewController.swift
//  WeatherMe

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
        print("this button was pressed")
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
        self.locationManager?.requestLocation()
        if self.currentLocation?.coordinate.latitude == nil && self.currentLocation?.coordinate.longitude == nil{
            presentAlert("Unsuccessful getting location coordinates", message: "Please enter valid information below.", cancelTitle: "OK")
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
    
    
    @IBAction func findMyLocationButtonTapped(_ sender: Any) {
//        print("this button was pressed")
//        self.locationManager = CLLocationManager()
//        self.locationManager?.delegate = self
//        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
//        self.locationManager?.requestWhenInUseAuthorization()
//        self.locationManager?.requestLocation()
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

extension UIViewController {
    
    /** Helper function to conveniently display an alert */
    
    func presentAlert(_ title: String, message: String, cancelTitle: String) {
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    /** Helper function to display an alert to a user*/
    
    func presentGenericErrorAlert(error: Error) {
        presentAlert("Error", message: "\(error.localizedDescription)", cancelTitle: "OK")
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

