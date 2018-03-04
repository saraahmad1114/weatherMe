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
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        if self.coordinateHolder != nil {
            
            guard let unwrappedLat = self.coordinateHolder?.coordinate.latitude else {print("lat did not unwrap"); return}
            guard let unwrappedLng = self.coordinateHolder?.coordinate.longitude else{print("lng did not unwrap"); return}
            
            self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (current, hourly, daily) in
    
                guard let location = self.weatherStore.currentWeatherArray.first?.timeZone else{print("location did not unwrap"); return}
                guard let time = self.weatherStore.currentWeatherArray.first?.time else{print("time did not unwrap"); return}
                guard let summary = self.weatherStore.currentWeatherArray.first?.summary else{print("summary did not unwrap"); return}
                guard let icon = self.weatherStore.currentWeatherArray.first?.icon else{print("icon did not unwrap"); return}
                guard let temperature = self.weatherStore.currentWeatherArray.first?.temperature else{print("temperature did not unwrap"); return}
                guard let precip = self.weatherStore.currentWeatherArray.first?.precipProbability else{print("precipProbability did not unwrap"); return}
                guard let humidity = self.weatherStore.currentWeatherArray.first?.humidity else{print("humidity did not unwrap"); return}
                guard let windSpeed = self.weatherStore.currentWeatherArray.first?.windSpeed else{print("windspeed did not unwrap"); return}
                
                OperationQueue.main.addOperation {
                    self.locationLabel.text = location
                    self.summaryLabel.text = summary
                    self.precipLabel.text = "\(String(Int(precip * 100))) %"
                    self.humidityLabel.text = "\(String(Int(humidity * 100))) %"
                    self.windSpeedLabel.text = "\(String(Int(windSpeed))) mph"
                    self.dayLabel.text = self.dayOfWeek(givenTime: time)
                    self.hourLabel.text = self.returnTimefrom(timeStamp: time)
                }
            })
        }
        else {
            //zip code
            guard let unwrappedZipcode = self.zipCode else {print("did not unwrap zipcode"); return}
            self.coordinateStore.getUserCoordintes(zipcode: unwrappedZipcode, completion: { (coordinatesJson) in
                
                guard let lat = self.coordinateStore.locationCoordinates.first?.latitude else{print("did not unwrap lat"); return}
                guard let lng = self.coordinateStore.locationCoordinates.first?.longitude else{print("did not unwrap lng"); return}

                self.weatherStore.getWeatherForecastInformation(lat: lat, lng: lng, completion: { (current, hourly, daily) in
                    
                    guard let location = self.weatherStore.currentWeatherArray.first?.timeZone else{print("location did not unwrap"); return}
                    guard let time = self.weatherStore.currentWeatherArray.first?.time else{print("time did not unwrap"); return}
                    guard let summary = self.weatherStore.currentWeatherArray.first?.summary else{print("summary did not unwrap"); return}
                    guard let icon = self.weatherStore.currentWeatherArray.first?.icon else{print("icon did not unwrap"); return}
                    guard let temperature = self.weatherStore.currentWeatherArray.first?.temperature else{print("temperature did not unwrap"); return}
                    guard let precip = self.weatherStore.currentWeatherArray.first?.precipProbability else{print("precipProbability did not unwrap"); return}
                    guard let humidity = self.weatherStore.currentWeatherArray.first?.humidity else{print("humidity did not unwrap"); return}
                    guard let windSpeed = self.weatherStore.currentWeatherArray.first?.windSpeed else{print("windspeed did not unwrap"); return}

                    OperationQueue.main.addOperation {
              
                        self.locationLabel.text = location
                        self.summaryLabel.text = summary
                        self.precipLabel.text = "\(String(Int(precip * 100))) %"
                        self.humidityLabel.text = "\(String(Int(humidity * 100))) %"
                        self.windSpeedLabel.text = "\(String(Int(windSpeed))) mph"
                        self.dayLabel.text = self.dayOfWeek(givenTime: time)
                        self.hourLabel.text = self.returnTimefrom(timeStamp: time)
 
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
    
    
    //SAVE THE FOLLOWING FUNCTIONS 
    
    //prints the following: "Mar 1, 2018 at 4:00:00 PM"
    //HELPS TO GET THE HOURS DOWN
    func convertTimestampHour (givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    //prints out Thursday - gets the day of the week
    func dayOfWeek(givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
    
    //returns the time from given string
    func returnTimefrom (timeStamp: Double) -> String{
        var neededHour = self.convertTimestampHour(givenTime: timeStamp)
        var justHourString = neededHour.components(separatedBy: "at")
        var takenHour = justHourString[1]
        return takenHour
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
