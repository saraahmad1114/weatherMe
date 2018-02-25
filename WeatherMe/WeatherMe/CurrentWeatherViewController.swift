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
    let coordinateStore = CoordinatesDatastore.sharedInstance
    let weatherStore = WeatherForecastLocationDatastore.sharedInstance
    
    @IBOutlet weak var temperatureUpdateLabel: UILabel!
    @IBOutlet weak var summaryUpdateLabel: UILabel!
    @IBOutlet weak var rainUpdateLabel: UILabel!
    @IBOutlet weak var dewUpdateLabel: UILabel!
    @IBOutlet weak var humidityUpdateLabel: UILabel!
    @IBOutlet weak var pressureUpdateLabel: UILabel!
    @IBOutlet weak var windUpdateLabel: UILabel!
    @IBOutlet weak var cloudUpdateLabel: UILabel!
    @IBOutlet weak var uvUpdateLabel: UILabel!
    @IBOutlet weak var ozoneUpdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        if self.coordinateHolder != nil {
            guard let unwrappedLat = self.coordinateHolder?.coordinate.latitude else {print("lat did not unwrap"); return}
            guard let unwrappedLng = self.coordinateHolder?.coordinate.longitude else{print("lng did not unwrap"); return}
            self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (current, hourly, daily) in
                print("CORE LOCATION HERE")
                print(current)
                print(hourly)
                print(daily)
                print("CORE LOCATION HERE")
                
                
                
            })

        }
        else {
            guard let unwrappedZipcode = self.zipCode else {print("did not unwrap zipcode"); return}
            self.coordinateStore.getUserCoordintes(zipcode: unwrappedZipcode, completion: { (coordinatesJson) in
                guard let lat = self.coordinateStore.locationCoordinates.first?.latitude else{print("did not unwrap lat"); return}
                guard let lng = self.coordinateStore.locationCoordinates.first?.longitude else{print("did not unwrap lng"); return}
                print("ZIP CODE HERE")
                print(lat)
                print(lng)
                print("ZIP CODE HERE")
                self.weatherStore.getWeatherForecastInformation(lat: lat, lng: lng, completion: { (current, hourly, daily) in
                    print("ZIP CODE HERE 2")
                    print(current)
                    print(hourly)
                    print(daily)
                    print("ZIP CODE HERE 2")
                })

            })
            
        }
    }
    
    
    func createGradientLayer() {
    self.currentVCGradientLayer = CAGradientLayer()
    self.currentVCGradientLayer.frame = self.view.bounds
    self.currentVCGradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
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
