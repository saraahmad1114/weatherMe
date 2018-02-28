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
    let coordinateStore = CoordinatesDatastore.sharedInstance
    let weatherStore = WeatherForecastLocationDatastore.sharedInstance
    
    @IBOutlet weak var temperatureUpdateLabel: UILabel!
    @IBOutlet weak var summaryUpdateLabel: UILabel!
    @IBOutlet weak var rainUpdateLabel: UILabel!
    @IBOutlet weak var dewUpdateLabel: UILabel!
    @IBOutlet weak var humidityUpdateLabel: UILabel!
    @IBOutlet weak var pressureUpdateLabel: UILabel!
    @IBOutlet weak var windUpdatLabel: UILabel!
    @IBOutlet weak var cloudUpdateLabel: UILabel!
    @IBOutlet weak var uvUpdateLabel: UILabel!
    @IBOutlet weak var ozoneUpdateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        if self.coordinateHolder != nil {
            //core location
            guard let unwrappedLat = self.coordinateHolder?.coordinate.latitude else {print("lat did not unwrap"); return}
            guard let unwrappedLng = self.coordinateHolder?.coordinate.longitude else{print("lng did not unwrap"); return}
            self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (current, hourly, daily) in

                guard let temperature = self.weatherStore.currentWeatherArray.first?.currentTemperature else{print("did not unwrap"); return}
                guard let summary = self.weatherStore.currentWeatherArray.first?.currentSummary else{print("did not unwrap"); return}
                guard let rain = self.weatherStore.currentWeatherArray.first?.currentPrecipProbability else{print("did not unwrap"); return}
                guard let dew = self.weatherStore.currentWeatherArray.first?.currentDewPoint else{print("did not unwrap"); return}
                guard let humidity = self.weatherStore.currentWeatherArray.first?.currentHumidity else{print("did not unwrap"); return}
                guard let pressure = self.weatherStore.currentWeatherArray.first?.currentPressure else{print("did not unwrap"); return}
                guard let wind = self.weatherStore.currentWeatherArray.first?.currentWindSpeed else{print("did not unwrap"); return}
                guard let cloud = self.weatherStore.currentWeatherArray.first?.currentCloudCover else{print("did not unwrap"); return}
                guard let uvIndex = self.weatherStore.currentWeatherArray.first?.currentUVIndex else{print("did not unwrap"); return}
                guard let ozone = self.weatherStore.currentWeatherArray.first?.currentOzone else{print("did not unwrap"); return}
                
                OperationQueue.main.addOperation {
                
                    self.temperatureUpdateLabel.text = String(describing: temperature)
                    self.summaryUpdateLabel.text = summary
                    self.rainUpdateLabel.text = String(describing: rain)
                    self.dewUpdateLabel.text = String(describing: dew)
                    self.humidityUpdateLabel.text = String(describing: humidity)
                    self.pressureUpdateLabel.text = String(describing: pressure)
                    self.windUpdatLabel.text = String(describing: wind)
                    self.cloudUpdateLabel.text = String(describing: cloud)
                    self.uvUpdateLabel.text = String(describing: uvIndex)
                    self.ozoneUpdateLabel.text = String(describing: ozone)
                }
            })
        }
        else {
            //zip code
            guard let unwrappedZipcode = self.zipCode else {print("did not unwrap zipcode"); return}
            self.coordinateStore.getUserCoordintes(zipcode: unwrappedZipcode, completion: { (coordinatesJson) in
                
                guard let lat = self.coordinateStore.locationCoordinates.first?.latitude else{print("did not unwrap lat"); return}
                guard let lng = self.coordinateStore.locationCoordinates.first?.longitude else{print("did not unwrap lng"); return}
                
                self.weatherStore.getWeatherForecastInformation(lat: lat, lng: -lng, completion: { (current, hourly, daily) in
                    
                    guard let temperature = self.weatherStore.currentWeatherArray.first?.currentTemperature else{print("did not unwrap"); return}
                    guard let summary = self.weatherStore.currentWeatherArray.first?.currentSummary else{print("did not unwrap"); return}
                    guard let rain = self.weatherStore.currentWeatherArray.first?.currentPrecipProbability else{print("did not unwrap"); return}
                    guard let dew = self.weatherStore.currentWeatherArray.first?.currentDewPoint else{print("did not unwrap"); return}
                    guard let humidity = self.weatherStore.currentWeatherArray.first?.currentHumidity else{print("did not unwrap"); return}
                    guard let pressure = self.weatherStore.currentWeatherArray.first?.currentPressure else{print("did not unwrap"); return}
                    guard let wind = self.weatherStore.currentWeatherArray.first?.currentWindSpeed else{print("did not unwrap"); return}
                    guard let cloud = self.weatherStore.currentWeatherArray.first?.currentCloudCover else{print("did not unwrap"); return}
                    guard let uvIndex = self.weatherStore.currentWeatherArray.first?.currentUVIndex else{print("did not unwrap"); return}
                    guard let ozone = self.weatherStore.currentWeatherArray.first?.currentOzone else{print("did not unwrap"); return}
                    OperationQueue.main.addOperation {
                        
                        self.temperatureUpdateLabel.text = String(describing: temperature)
                        self.summaryUpdateLabel.text = summary
                        self.rainUpdateLabel.text = String(describing: rain)
                        self.dewUpdateLabel.text = String(describing: dew)
                        self.humidityUpdateLabel.text = String(describing: humidity)
                        self.pressureUpdateLabel.text = String(describing: pressure)
                        self.windUpdatLabel.text = String(describing: wind)
                        self.cloudUpdateLabel.text = String(describing: cloud)
                        self.uvUpdateLabel.text = String(describing: uvIndex)
                        self.ozoneUpdateLabel.text = String(describing: ozone)
                    }
                   
                })

            })
            
        }
    }
    
    
    func createGradientLayer() {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at:0)
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
