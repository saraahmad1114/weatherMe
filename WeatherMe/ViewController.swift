//
//  ViewController.swift
//  WeatherMe

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    let store = CoordinatesDatastore.sharedInstance
    
    @IBOutlet weak var insertZipcodeLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var checkZipCodeButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var findMyLocationButton: UIButton!
    @IBOutlet weak var getWeatherForecastButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        createCustomTextField(given: "Enter Zipcode Here", textfield: self.zipCodeTextField)
        createCustomLabel(label: self.insertZipcodeLabel)
        createCustomLabel(label: self.orLabel)
        createButtonColor(button: self.checkZipCodeButton)
        createButtonColor(button: self.findMyLocationButton)
        createButtonColor(button: self.getWeatherForecastButton)
    }

    func isZipCodeValid(text: String) -> Bool {
        let zipCodeTestPredicate = NSPredicate (format:"SELF MATCHES %@","(^[0-9]{5}(-[0-9]{4})?$)")
        return zipCodeTestPredicate.evaluate(with: zipCodeTextField.text)
    }
    
    @IBAction func checkZipCodeButtonTapped(_ sender: Any) {
        if self.zipCodeTextField.text?.count == 5 && isZipCodeValid(text: self.zipCodeTextField.text!) == true {
            createAlertViewController(title: "Correct Zipcode", message: "Correct Zipcode")
        }
        else {
            createAlertViewController(title: "Incorrect Zipcode", message: "Incorrect Zipcode")
        }
    }
    
    @IBAction func findMyLocationButtonTapped(_ sender: Any) {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self as? CLLocationManagerDelegate
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "getWeatherInfo" {
        if let destinationVC = segue.destination as? CurrentWeatherViewController{
            if self.currentLocation != nil {
                guard let latestCoordinates = self.currentLocation else {print("latestCoordinates did not unwrap"); return}
                destinationVC.coordinateHolder = self.currentLocation
            }
            else if self.zipCodeTextField.text != nil{
                guard let neededZipcode = self.zipCodeTextField.text else {print("neededZipcode did not unwrap"); return}
                destinationVC.zipCode = self.zipCodeTextField.text
                }
            }
        }
    }
}
    
func createAlertViewController(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
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


