//
//  CurrentWeatherViewController.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {
    
    var coordinateHolder: CLLocation?
    var zipCode: String?
    var currentVCGradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Entered here")
        createGradientLayer()
    }
    
    
    func createGradientLayer() {
    self.currentVCGradientLayer = CAGradientLayer()
    self.currentVCGradientLayer.frame = self.view.bounds
    self.currentVCGradientLayer.colors = [UIColor.blue.cgColor, UIColor.white.cgColor]
    self.view.layer.addSublayer(self.currentVCGradientLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
