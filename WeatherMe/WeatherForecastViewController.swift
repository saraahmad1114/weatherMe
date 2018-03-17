//
//  WeatherForecastViewController.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/17/18.

//

import UIKit


import UIKit
import CoreLocation

class WeatherForecastViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var coordinateHolder: CLLocation?
    var zipCode: String?
    let coordinateStore = CoordinatesDatastore.sharedInstance
    let weatherStore = WeatherForecastLocationDatastore.sharedInstance
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var completeDateLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var humdityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var hourlyWeatherTable: UITableView!
    @IBOutlet weak var dailyWeatherColl: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.coordinateHolder != nil {
            guard let unwrappedLat = self.coordinateHolder?.coordinate.latitude else {print("lat did not unwrap"); return}
            guard let unwrappedLng = self.coordinateHolder?.coordinate.longitude else{print("lng did not unwrap"); return}
            self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (current, hourly, daily) in
                self.parseNeededDataAndDisplay()
            })
        }
        else {
            guard let unwrappedZipcode = self.zipCode else {print("did not unwrap zipcode"); return}
            self.coordinateStore.getUserCoordintes(zipcode: unwrappedZipcode, completion: { (coordinatesJson) in
                guard let lat = self.coordinateStore.locationCoordinates.first?.latitude else{print("did not unwrap lat"); return}
                guard let lng = self.coordinateStore.locationCoordinates.first?.longitude else{print("did not unwrap lng"); return}
                self.weatherStore.getWeatherForecastInformation(lat: lat, lng: lng, completion: { (current, hourly, daily) in
                   self.parseNeededDataAndDisplay()
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

            if let neededDay = self.weatherStore.dailyWeatherArray[neededRow].dailyTime{
                var day = self.dayOfWeek(givenTime: neededDay)
                let index = day.index(day.startIndex, offsetBy: 3)
                let smallerDay = day[..<index]
                cell.dailyDayLabel.text = String(smallerDay)
            }
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
                else if neededIcon == "tornado"{
                    cell.dailyIconImage.image = UIImage(named: "tornado")
                }
                else if neededIcon == "wind"{
                    cell.dailyIconImage.image = UIImage(named: "wind")
                }
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherStore.hourlyWeatherArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyWeatherCell", for: indexPath) as! HourlyWeatherTableViewCell

        if let neededHourlyTime = self.weatherStore.hourlyWeatherArray[indexPath.row].hourlyTime{
            let cellTime = self.returnHourFromTime(timeStamp: neededHourlyTime)
            cell.hourlyTimeLabel.text = cellTime
        }

        if let needeHourlytemperature = self.weatherStore.hourlyWeatherArray[indexPath.row].hourlyTemperature{
            cell.hourlyTempLabel.text = String(Int(needeHourlytemperature))
        }

        if let neededHourlyIcon = self.weatherStore.hourlyWeatherArray[indexPath.row].hourlyIcon{
            if neededHourlyIcon == "clear-day"{
                cell.hourlyIconImage.image = UIImage(named:"clear-day")
            }
            else if neededHourlyIcon == "clear-night"{
                cell.hourlyIconImage.image = UIImage(named: "clear-night")
            }
            else if neededHourlyIcon == "cloudy"{
                cell.hourlyIconImage.image = UIImage(named: "cloudy")
            }
            else if neededHourlyIcon == "fog"{
                cell.hourlyIconImage.image = UIImage(named:"fog")
            }
            else if neededHourlyIcon == "hail"{
                cell.hourlyIconImage.image = UIImage(named: "hail")
            }
            else if neededHourlyIcon == "partly-cloudy-day"{
                cell.hourlyIconImage.image = UIImage(named: "partly-cloudy-day")
            }
            else if neededHourlyIcon == "partly-cloudy-night"{
                cell.hourlyIconImage.image = UIImage(named: "partly-cloudy-night")
            }
            else if neededHourlyIcon == "rain"{
                cell.hourlyIconImage.image = UIImage(named: "rain")
            }
            else if neededHourlyIcon == "sleet"{
                cell.hourlyIconImage.image = UIImage(named: "sleet")
            }
            else if neededHourlyIcon == "snow"{
                cell.hourlyIconImage.image = UIImage(named: "snow")
            }
            else if neededHourlyIcon == "thunderstorm"{
                cell.hourlyIconImage.image = UIImage(named: "thunderstorm")
            }
            else if neededHourlyIcon == "tornado"{
                cell.hourlyIconImage.image = UIImage(named: "tornado")
            }
            else if neededHourlyIcon == "wind"{
                cell.hourlyIconImage.image = UIImage(named: "wind")
            }
        }
        return cell
    }
    
    //returns the date in format: Month date, year
    func convertToDate (givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    //returns only the day of the week 
    func dayOfWeek(givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
    
    //returns 07:00 PM
    func returnHourFromTime (timeStamp: Double) -> String{
        let date = Date(timeIntervalSince1970: timeStamp)
        let formater = DateFormatter()
        formater.timeZone = TimeZone.current
        formater.dateFormat = "hh:mm a"
        formater.amSymbol = "AM"
        formater.pmSymbol = "PM"
        let localDate = formater.string(from: date)
        return localDate
    }
    
    func parseNeededDataAndDisplay(){
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
            self.precipitationLabel.text = "Precipitation: \(String(Int(precip * 100))) %"
            self.humdityLabel.text = "Humidity: \(String(Int(humidity * 100))) %"
            self.windSpeedLabel?.text = "Wind Speed: \(String(Int(windSpeed))) mph"
            self.currentTempLabel.text = "\(String(Int(temperature))) F"
            self.returnImageForIcon(icon: icon)
            self.completeDateLabel.text = "\(self.dayOfWeek(givenTime: time)), \(self.convertToDate(givenTime: time))"
            self.hourlyWeatherTable.reloadData()
            self.dailyWeatherColl.reloadData()
        }
    }
    
    //fixs location String for better display
    func returnLocationString (location: String) -> String{
        var locationString = location.components(separatedBy: "/")
        return locationString[1].replacingOccurrences(of: "_", with: " ")
    }
    
        func returnImageForIcon (icon: String){
            if icon == "clear-day"{
                self.currentWeatherIcon.image = UIImage(named:"clear-day")
            }
            else if icon == "clear-night"{
                self.currentWeatherIcon.image = UIImage(named: "clear-night")
            }
            else if icon == "cloudy"{
                self.currentWeatherIcon.image = UIImage(named: "cloudy")
            }
            else if icon == "fog"{
               self.currentWeatherIcon.image = UIImage(named: "fog")
            }
            else if icon == "hail"{
                self.currentWeatherIcon.image = UIImage(named:"hail")
            }
            else if icon == "partly-cloudy-day"{
                self.currentWeatherIcon.image = UIImage(named:"partly-cloudy-day")
            }
            else if icon == "partly-cloudy-night"{
                self.currentWeatherIcon.image = UIImage(named:"partly-cloudy-night")
            }
            else if icon == "rain"{
                self.currentWeatherIcon.image = UIImage(named:"rain")
            }
            else if icon == "sleet"{
                self.currentWeatherIcon.image = UIImage(named:"sleet")
            }
            else if icon == "snow"{
                self.currentWeatherIcon.image = UIImage(named:"snow")
            }
            else if icon == "thunderstorm"{
                self.currentWeatherIcon.image = UIImage(named:"thunderstorm")
            }
            else if icon == "tornado"{
                self.currentWeatherIcon.image = UIImage(named:"tornado")
            }
            else if icon == "wind"{
                self.currentWeatherIcon.image = UIImage(named:"wind")
            }
        }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

