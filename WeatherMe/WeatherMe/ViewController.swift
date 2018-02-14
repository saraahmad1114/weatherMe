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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        createCustomTextField(textfield: self.zipCodeTextField)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.insertZipcodeLabel.textColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


