//
//  WeatherForecastViewController.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherForecastViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //variables to hold coordinates from core location
    var coordinateHolder: CLLocation?
    
    //variables to hold user input
    var currentLng: Double?
    var currentLat: Double?
    var zipCode: String?
    
    //reference to the functions in the datastore parsing json and turning it into Swift objects
    let coordinateStore = CoordinatesDatastore.sharedInstance
    let weatherStore = WeatherForecastLocationDatastore.sharedInstance
    
    //variables to hold the contents of the function calls
    var currentWeatherForecast = [CurrentWeather]()
    var hourlyWeatherForecast = [HourlyWeather]()
    var dailyWeatherForecast = [DailyWeather]()

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
    
    override func viewWillAppear(_ animated: Bool) {
        createEmptyState()
    }
    
    func createEmptyState() {
        self.coordinateHolder = nil
        self.zipCode = nil
        self.currentWeatherForecast.removeAll()
        self.hourlyWeatherForecast.removeAll()
        self.dailyWeatherForecast.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //CORE LOCATION OPTION
        if self.coordinateHolder != nil {
            guard let unwrappedLat = coordinateHolder?.coordinate.latitude else {print("lat did not unwrap"); return}
            guard let unwrappedLng = coordinateHolder?.coordinate.longitude else{print("lng did not unwrap"); return}            
            do {
                try
                    self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (current, hourly, daily) in
                        self.currentWeatherForecast = current
                        self.hourlyWeatherForecast = hourly
                        self.dailyWeatherForecast = daily
                self.parseNeededDataAndDisplay()
                })
            } catch let error {
                print("error here is: \(error.localizedDescription)")
            }
        }
        
        //USER INPUT, INSTEAD OF CORE LOCATION
        else if self.zipCode != nil {
            guard let unwrappedZipcode = self.zipCode else {print("did not unwrap zipcode"); return}
            do {
               try
                self.coordinateStore.getUserCoordintes(zipcode: unwrappedZipcode, completion: { (coordinatesJson) in
                    self.currentLat = coordinatesJson.first?.latitude
                    self.currentLng = coordinatesJson.first?.longitude
                    guard let lat = self.currentLat else {print("did not unwrap latitude for core location"); return}
                    guard let lng = self.currentLng else {print("did not unwrap longitude for core location"); return}
                    
                    do {
                      try self.weatherStore.getWeatherForecastInformation(lat: lat, lng: lng, completion: { (current, hourly, daily) in
                        self.currentWeatherForecast = current
                        self.hourlyWeatherForecast = hourly
                        self.dailyWeatherForecast = daily
                           self.parseNeededDataAndDisplay()
                        })
                    } catch let error {
                        print("error is: \(error.localizedDescription)")
                    }
                })
                } catch let error {
                    print("error is: \(error.localizedDescription)")
                }
        }
    }
    
    //DAILY WEATHER
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dailyWeatherForecast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dailyWeatherCell", for: indexPath) as! DailyWeatherCollectionViewCell
        let neededRow = indexPath.row
        if let neededDay = self.dailyWeatherForecast[neededRow].dailyTime{
            let day = self.dayOfWeek(givenTime: neededDay)
            let index = day.index(day.startIndex, offsetBy: 3)
            let smallerDay = day[..<index]
            cell.dailyDayLabel.text = String(smallerDay)
        }
    
        if let neededTempHigh = self.dailyWeatherForecast[neededRow].dailyTemperatureHigh{
            if let neededTempLow = self.dailyWeatherForecast[neededRow].dailyTemperatureLow{
                cell.dailyTempLabel.text = "\(String(Int(neededTempHigh))) / \(String(Int(neededTempLow)))"
            }
        }
        
        if let neededIcon = self.dailyWeatherForecast[neededRow].dailyIcon{
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
    
    //HOURLY WEATHER
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hourlyWeatherForecast.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hourlyWeatherCell", for: indexPath) as! HourlyWeatherTableViewCell
        
        if let neededHourlyTime = self.hourlyWeatherForecast[indexPath.row].hourlyTime{
            let cellTime = self.returnHourFromTime(timeStamp: neededHourlyTime)
            cell.hourlyTimeLabel.text = cellTime
        }
        
        if let needeHourlytemperature = self.hourlyWeatherForecast[indexPath.row].hourlyTemperature{
            cell.hourlyTempLabel.text = String(Int(needeHourlytemperature))
        }
        
        if let neededHourlyIcon = self.hourlyWeatherForecast[indexPath.row].hourlyIcon{
            if neededHourlyIcon == "clear-day"{
                cell.hourlyIconImage.image = UIImage(named:"clear-day")
            }
            else if neededHourlyIcon == "cloudy"{
                cell.hourlyIconImage.image = UIImage(named:"cloudy")
            }
            else if neededHourlyIcon == "fog"{
                cell.hourlyIconImage.image = UIImage(named:"fog")
            }
            else if neededHourlyIcon == "hail"{
                cell.hourlyIconImage.image = UIImage(named:"hail")
            }
            else if neededHourlyIcon == "rain"{
                cell.hourlyIconImage.image = UIImage(named:"rain")
            }
            else if neededHourlyIcon == "sleet"{
                cell.hourlyIconImage.image = UIImage(named:"sleet")
            }
            else if neededHourlyIcon == "snow"{
                cell.hourlyIconImage.image = UIImage(named:"snow")
            }
            else if neededHourlyIcon == "wind"{
                cell.hourlyIconImage.image = UIImage(named:"wind")
            }
            else if neededHourlyIcon == "clear-night"{
                cell.hourlyIconImage.image = UIImage(named:"clear-night")
            }
            else if neededHourlyIcon == "thunderstorm"{
                cell.hourlyIconImage.image = UIImage(named:"thunderstorm")
            }
            else if neededHourlyIcon == "tornado"{
                cell.hourlyIconImage.image = UIImage(named:"tornado")
            }
            else if neededHourlyIcon == "partly-cloudy-day"{
                cell.hourlyIconImage.image = UIImage(named:"partly-cloudy-day")
            }
            else if neededHourlyIcon == "partly-cloudy-night"{
                cell.hourlyIconImage.image = UIImage(named:"partly-cloudy-night")
            }
        }
        return cell
    }
    
    
    //CREATE AN EXTENSION TO ORGANIZE ALL OF THESE
    func convertToDate (givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    func dayOfWeek(givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
    
    func returnHourFromTime (timeStamp: Double) -> String{
        let date = Date(timeIntervalSince1970: timeStamp)
        let formater = DateFormatter()
        formater.timeZone = TimeZone.current
        formater.dateFormat = "hh a"
        formater.amSymbol = "AM"
        formater.pmSymbol = "PM"
        let localDate = formater.string(from: date)
        return localDate
    }
    
    func parseNeededDataAndDisplay() {

        guard let location = self.currentWeatherForecast.first?.timeZone else{print("location did not unwrap"); return}
        guard let time = self.currentWeatherForecast.first?.time else{print("time did not unwrap"); return}
        guard let summary = self.currentWeatherForecast.first?.summary else{print("summary did not unwrap"); return}
        guard let icon = self.currentWeatherForecast.first?.icon else{print("icon did not unwrap"); return}
        guard let temperature = self.currentWeatherForecast.first?.temperature else{print("temperature did not unwrap"); return}
        guard let precip = self.currentWeatherForecast.first?.precipProbability else{print("precipProbability did not unwrap"); return}
        guard let humidity = self.currentWeatherForecast.first?.humidity else{print("humidity did not unwrap"); return}
        guard let windSpeed = self.currentWeatherForecast.first?.windSpeed else{print("windspeed did not unwrap"); return}
        
        OperationQueue.main.addOperation {
            self.locationLabel.text = self.returnLocationString(location: location)
            self.summaryLabel.text = summary
            self.precipitationLabel.text = "Precipitation: \(String(precip * 100)) %"
            self.humdityLabel.text = "Humidity: \(String(humidity * 100)) %"
            self.windSpeedLabel?.text = "Wind Speed: \(String(windSpeed)) mph"
            self.currentTempLabel.text = "\(String(Int(temperature))) °F"
            self.returnImageForIcon(icon: icon)
            self.completeDateLabel.text = "\(self.dayOfWeek(givenTime: time)), \(self.convertToDate(givenTime: time))"
            self.hourlyWeatherTable.reloadData()
            self.dailyWeatherColl.reloadData()
        }
    }
    
    
    //THIS FUNCTION WILL MOST LIKELY BE OMITTED
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
    
    
    //EVERYTHING IS RESET ONCE YOU HIT THE RESET BUTTON
    @IBAction func resetButtonTapped(_ sender: Any) {
        self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
        self.coordinateHolder = nil
        self.zipCode = nil
        self.currentWeatherForecast.removeAll()
        self.hourlyWeatherForecast.removeAll()
        self.dailyWeatherForecast.removeAll()
        self.currentLat = nil
        self.currentLng = nil
    }
}

//NEEDS TO BE PUT INTO ANOTHER EXTENSION FILE FOR ORGANIZATION PURPOSES
extension UIViewController {
    func presentAlert(_ title: String, message: String, cancelTitle: String) {
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel, handler: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    func presentGenericErrorAlert(error: Error) {
        presentAlert("Error", message: "\(error.localizedDescription)", cancelTitle: "OK")
    }
}

