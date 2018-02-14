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
    
    var gradientLayer: CAGradientLayer!
    @IBOutlet weak var insertZipcodeLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var checkZipCodeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        createCustomTextField(textfield: self.zipCodeTextField)
        self.checkZipCodeButton.tintColor = UIColor.gray
    }
    
    func createGradientLayer() {
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    func createCustomTextField (textfield: UITextField){
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
    }
    
    func isZipCodeValid(text: String) -> Bool
    {
        let zipCodeTestPredicate = NSPredicate (format:"SELF MATCHES %@","(^[0-9]{5}(-[0-9]{4})?$)")
        return zipCodeTestPredicate.evaluate(with: zipCodeTextField.text)
    }
    
    @IBAction func checkZipCodeButtonTapped(_ sender: Any) {
        if self.zipCodeTextField.text?.count == 5 && isZipCodeValid(text: self.zipCodeTextField.text!) == true
        {
            let alertController = UIAlertController(title: "Correct Zipcode", message: "Correct zipCode Input!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
            
        else  {
            let alertController = UIAlertController(title: "Incorrect Zipcode", message: "Invalid zipcode input!", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


