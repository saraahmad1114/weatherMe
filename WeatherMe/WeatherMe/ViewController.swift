//
//  ViewController.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
        
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var insertZipcodeLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var checkZipCodeButton: UIButton!
    @IBOutlet weak var orLabel: UILabel!
    @IBOutlet weak var findMyLocationButton: UIButton!
    @IBOutlet weak var getWeatherForecastButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        createCustomTextField(textfield: self.zipCodeTextField)
        self.checkZipCodeButton.tintColor = UIColor.gray
        self.findMyLocationButton.tintColor = UIColor.gray
        self.getWeatherForecastButton.tintColor = UIColor.gray

    }
    
    func createGradientLayer() {
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func createCustomTextField (textfield: UITextField) {
          let placeholder = NSAttributedString(string: "Enter ZipCode Here", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
          textfield.attributedPlaceholder = placeholder
          textfield.textColor = UIColor.gray
          textfield.borderStyle = UITextBorderStyle.roundedRect
          textfield.clearsOnBeginEditing = true
    }
    
    func createCustomLabel (label: UILabel){
        label.textColor = UIColor.gray
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createCustomLabel(label: self.insertZipcodeLabel)
        createCustomLabel(label: self.orLabel)
    }
    
    func isZipCodeValid(text: String) -> Bool {
        let zipCodeTestPredicate = NSPredicate (format:"SELF MATCHES %@","(^[0-9]{5}(-[0-9]{4})?$)")
        return zipCodeTestPredicate.evaluate(with: zipCodeTextField.text)
    }
    
    @IBAction func checkZipCodeButtonTapped(_ sender: Any) {
        if self.zipCodeTextField.text?.count == 5 && isZipCodeValid(text: self.zipCodeTextField.text!) == true {
            let alertController = UIAlertController(title: "Correct Zipcode", message: "Correct zipCode Input!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Incorrect Zipcode", message: "Invalid zipcode input!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func findMyLocationButtonTapped(_ sender: Any) {
        self.locationManager = CLLocationManager()
        self.locationManager?.delegate = self as? CLLocationManagerDelegate
        self.locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager?.requestWhenInUseAuthorization()
    }

    
   func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
    print("entered here")
    if segue.identifier == "getWeatherInfo" {
        if let destinationVC = segue.destination as? CurrentWeatherViewController{
            if self.currentLocation != nil {
                //tried unwrapping here
                guard let latestCoordinates = self.currentLocation else {print("latestCoordinates did not unwrap"); return}
                destinationVC.coordinateHolder = self.currentLocation
                print(destinationVC.coordinateHolder)
            }
            else if self.zipCodeTextField.text != nil{
                //tried unwrapping here
                guard let neededZipcode = self.zipCodeTextField.text else {print("neededZipcode did not unwrap"); return}
                destinationVC.zipCode = self.zipCodeTextField.text
                print(destinationVC.zipCode)
                }
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if self.currentLocation == nil {
            self.currentLocation = locations.first
            print(self.currentLocation)
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


