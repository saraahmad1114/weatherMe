//
//  CurrentWeatherViewController.swift
//  WeatherMe
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
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
                    self.windSpeedLabel?.text = "\(String(Int(windSpeed))) mph"
                    self.dayLabel.text = self.dayOfWeek(givenTime: time)
                    self.hourLabel.text = self.returnTimefrom(timeStamp: time)
                    self.tempLabel.text = "\(String(Int(temperature))) F"
                    self.returnImageForIcon(icon: icon)
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
                        self.returnImageForIcon(icon: icon)
                    }
                })
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.weatherStore.dailyWeatherArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyWeatherCell", for: indexPath) as! DailyWeatherCollectionViewCell
        
        let neededRow = indexPath.row
        
        //updating the dayLabel
        if let neededDay = self.weatherStore.dailyWeatherArray[neededRow].dailyTime{
            var day = dayOfWeek(givenTime: neededDay)
            let index = day.index(day.startIndex, offsetBy: 3)
            let smallerDay = day[..<index]
            cell.dailyDayLabel.text = String(smallerDay)
        }
        
        //updating the temperature Label
        if let neededTempHigh = self.weatherStore.dailyWeatherArray[neededRow].dailyTemperatureHigh{
            if let neededTempLow = self.weatherStore.dailyWeatherArray[neededRow].dailyTemperatureLow{
                cell.dailyTempLabel.text = "\(String(Int(neededTempHigh))) / \(String(Int(neededTempLow)))"
            }
        }
        
        if let neededIcon = self.weatherStore.dailyWeatherArray[neededRow].dailyIcon{
            if neededIcon == "clear-day"{
                cell.dailyIconImage.image = UIImage(named:"clear-day")
            }
            else if neededIcon == "clear-night"{
                 cell.dailyIconImage.image = UIImage(named: "clear-night")
            }
            else if neededIcon == "cloudy"{
                cell.dailyIconImage.image = UIImage(named: "cloudy")
            }
            else if neededIcon == "fog"{
                cell.dailyIconImage.image = UIImage(named:"fog")
            }
            else if neededIcon == "hail"{
                cell.dailyIconImage.image = UIImage(named: "hail")
            }
            else if neededIcon == "partly-cloudy-day"{
                cell.dailyIconImage.image = UIImage(named: "partly-cloudy-day")
            }
            else if neededIcon == "partly-cloudy-night"{
                cell.dailyIconImage.image = UIImage(named: "partly-cloudy-night")
            }
            else if neededIcon == "rain"{
                cell.dailyIconImage.image = UIImage(named: "rain")
            }
            else if neededIcon == "sleet"{
                cell.dailyIconImage.image = UIImage(named: "sleet")
            }
            else if neededIcon == "snow"{
                cell.dailyIconImage.image = UIImage(named: "snow")
            }
            else if neededIcon == "thunderstorm"{
                cell.dailyIconImage.image = UIImage(named: "thunderstorm")
            }
        }
        
        
        
        return cell
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
    
    func returnImageForIcon (icon: String){
        if icon == "clear-day"{
            self.iconImage.image = UIImage(named:"clear-day")
        }
        else if icon == "clear-night"{
            self.iconImage.image = UIImage(named: "clear-night")
        }
        else if icon == "cloudy"{
            self.iconImage.image = UIImage(named: "cloudy")
        }
        else if icon == "fog"{
           self.iconImage.image = UIImage(named: "fog")
        }
        else if icon == "hail"{
            self.iconImage.image = UIImage(named:"hail")
        }
        else if icon == "partly-cloudy-day"{
            self.iconImage.image = UIImage(named:"partly-cloudy-day")
        }
        else if icon == "partly-cloudy-night"{
            self.iconImage.image = UIImage(named:"partly-cloudy-night")
        }
        else if icon == "rain"{
            self.iconImage.image = UIImage(named:"rain")
        }
        else if icon == "sleet"{
            self.iconImage.image = UIImage(named:"sleet")
        }
        else if icon == "snow"{
            self.iconImage.image = UIImage(named:"snow")
        }
        else if icon == "thunderstorm"{
            self.iconImage.image = UIImage(named:"thunderstorm")
        }
        else if icon == "tornado"{
            self.iconImage.image = UIImage(named:"tornado")
        }
        else if icon == "wind"{
            self.iconImage.image = UIImage(named:"wind")
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
