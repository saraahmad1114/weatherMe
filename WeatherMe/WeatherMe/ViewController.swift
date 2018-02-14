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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let placeholder = NSAttributedString(string: "Enter here", attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightGray])
        
//        self.zipCodeTextField = UITextField(frame: CGRect(x: 50, y: 100, width: 200, height: 20))
//        self.zipCodeTextField.attributedPlaceholder = placeholder
//        self.zipCodeTextField.textColor = UIColor.black
////        self.zipCodeTextField.delegate = self as! UITextFieldDelegate
//        self.zipCodeTextField.borderStyle = UITextBorderStyle.roundedRect
//
//       // self.zipCodeTextField.background = UIColor.white
//        self.zipCodeTextField.clearsOnBeginEditing = true
//        view.addSubview(self.zipCodeTextField)
        
    }
    
    func createGradientLayer() {
        self.gradientLayer = CAGradientLayer()
        self.gradientLayer.frame = self.view.bounds
        self.gradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
        self.view.layer.addSublayer(gradientLayer)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createGradientLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


