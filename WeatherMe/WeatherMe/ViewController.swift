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
        
        let placeholder = NSAttributedString(string: "Enter ZipCode Here", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        self.zipCodeTextField.attributedPlaceholder = placeholder
        self.zipCodeTextField.textColor = UIColor.gray
        self.zipCodeTextField.borderStyle = UITextBorderStyle.roundedRect
        self.zipCodeTextField.clearsOnBeginEditing = true
    }
    
    func createGradientLayer() {
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.insertZipcodeLabel.textColor = UIColor.gray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


