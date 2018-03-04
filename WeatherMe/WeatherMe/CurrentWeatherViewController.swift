//
//  CurrentWeatherViewController.swift
//  WeatherMe
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
    @IBOutlet weak var tempLabel: UILabel!
    
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
                    self.locationLabel.text = self.returnLocationString(location: location)
                    self.summaryLabel.text = summary
                    self.precipLabel.text = "\(String(Int(precip * 100))) %"
                    self.humidityLabel.text = "\(String(Int(humidity * 100))) %"
                    self.windSpeedLabel.text = "\(String(Int(windSpeed))) mph"
                    self.dayLabel.text = self.dayOfWeek(givenTime: time)
                    self.hourLabel.text = self.returnTimefrom(timeStamp: time)
                    self.tempLabel.text = "\(String(Int(temperature))) F"
                    self.returnImageForIcon(icon: icon, iconImg: &self.iconImage)
                }
            })
        }
        else {
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
                        self.locationLabel.text = self.returnLocationString(location: location)
                        self.summaryLabel.text = summary
                        self.precipLabel.text = "\(String(Int(precip * 100))) %"
                        self.humidityLabel.text = "\(String(Int(humidity * 100))) %"
                        self.windSpeedLabel.text = "\(String(Int(windSpeed))) mph"
                        self.dayLabel.text = self.dayOfWeek(givenTime: time)
                        self.hourLabel.text = self.returnTimefrom(timeStamp: time)
                        self.tempLabel.text = "\(String(Int(temperature))) F"
                        self.returnImageForIcon(icon: icon, iconImg: &self.iconImage)
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
    
    func convertTimestampHour (givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func dayOfWeek(givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
    
    func returnTimefrom (timeStamp: Double) -> String{
        let neededHour = self.convertTimestampHour(givenTime: timeStamp)
        var justHourString = neededHour.components(separatedBy: "at")
        let takenHour = justHourString[1]
        return takenHour
    }
    
    func returnLocationString (location: String) -> String{
        var locationString = location.components(separatedBy: "/")
        return locationString[1].replacingOccurrences(of: "_", with: " ")
    }
    
    func returnImageForIcon (icon: String, iconImg: inout UIImageView!){
        if icon == "clear-day"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "clear-day"))
        }
        else if icon == "clear-night"{
            iconImg = UIImageView(image: #imageLiteral(resourceName: "clear-day"))
        }
        else if icon == "cloudy"{
            iconImg = UIImageView(image: #imageLiteral(resourceName: "cloudy"))
        }
        else if icon == "fog"{
           iconImg = UIImageView(image: #imageLiteral(resourceName: "fog"))
        }
        else if icon == "hail"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "hail"))
        }
        else if icon == "partly-cloudy-day"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "partly-cloudy-day"))
        }
        else if icon == "partly-cloudy-night"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "partly-cloudy-night"))
        }
        else if icon == "rain"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "rain"))
        }
        else if icon == "sleet"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "sleet"))
        }
        else if icon == "snow"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "snow"))
        }
        else if icon == "thunderstorm"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "thunderstorm"))
        }
        else if icon == "tornado"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "tornado"))
        }
        else if icon == "wind"{
            iconImg = UIImageView(image:#imageLiteral(resourceName: "wind"))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
