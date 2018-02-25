//
//  WeatherForecastLocationDatastore.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 2/19/18.
//  Copyright © 2018 Flatiron School. All rights reserved.
//

import Foundation

class WeatherForecastLocationDatastore{

    static let sharedInstance = WeatherForecastLocationDatastore()
    private init() {}
    
    var currentWeatherArray = [CurrentWeather]()
    var hourlyWeatherArray = [HourlyWeather]()
    var dailyWeatherArray = [DailyWeather]()
    
    func getWeatherForecastInformation(lat: Double, lng: Double, completion:@escaping ([CurrentWeather], [HourlyWeather], [DailyWeather]) -> ()){
        
        DarkSkyAPIClient.getWeatherInformation(lat: lat, lng: lng) { (darkSkyJson) in
            
            guard let jsonDictionary = darkSkyJson as? [String: Any] else {print("first level dictionary did not unwrap"); return}
            
            guard let currentDictionary = jsonDictionary["currently"] as? [String: Any] else{print("did not unwrap currentDictionary did not unwrap"); return}
            
            guard let summary = currentDictionary["summary"] as? String else {print("did not unwrap currentSummary"); return}
            
            guard let icon = currentDictionary["icon"] as? String else {print("did not unwrap currentIcon"); return}
            
            guard let precipProb = currentDictionary["precipProbability"] as? Double else{print("did not unwrap currentPrecipProbability"); return}
            
            guard let temperature = currentDictionary["temperature"] as? Double else{print("did not unwrap currentTemperature"); return}
            
            guard let dewPoint = currentDictionary["dewPoint"] as? Double else{print("did not unwrap currentDewPoint"); return}
            
            guard let humidity = currentDictionary["humidity"] as? Double else{print("did not unwrap currentHumidity"); return}
            
            guard let pressure = currentDictionary["pressure"] as? Double else{print("did not unwrap currentPressue"); return}
            
            guard let windSpeed = currentDictionary["windSpeed"] as? Double else{print("did not unwrap currentWindSpeed"); return}
            
            guard let cloudCover = currentDictionary["cloudCover"] as? Double else{print("did not unwrap currentCloudCover"); return}
            
            guard let uVIndex = currentDictionary["uvIndex"] as? Double else{print("did not unwrap currentUVIndex"); return}
            
            guard let ozone = currentDictionary["ozone"] as? Double else{print("did not unwrap currentOzone"); return}
            
            let currentWeatherForecastObj = CurrentWeather.init(currentSummary: summary, currentIcon: icon, currentPrecipProbability: precipProb, currentTemperature: temperature, currentDewPoint: dewPoint, currentHumidity: humidity, currentPressure: pressure, currentWindSpeed: windSpeed, currentCloudCover: cloudCover, currentUVIndex: uVIndex, currentOzone: ozone)
            
            self.currentWeatherArray.append(currentWeatherForecastObj)

            guard let hourlyDictionary = darkSkyJson["hourly"] as? [String: Any] else{print("did not unwrap hourlyDictionary"); return}

            guard let dataArray = hourlyDictionary["data"] as? Array<Any> else{print("did not unwrap dataArray"); return}
            
            for singleDictionary in dataArray{
                guard let unwrappedSingleDictionary = singleDictionary as? [String: Any] else{print("singleDictionary did not unwrap"); return}
                let hourlyForecastObj = HourlyWeather.init(jsonDictionary: unwrappedSingleDictionary)
                self.hourlyWeatherArray.append(hourlyForecastObj)
            }
            
            guard let dailyDictionary = jsonDictionary["daily"] as? [String: Any] else{print("dailyDictionary did not unwrap"); return}
            
            guard let dataDailyArray = dailyDictionary["data"] as? Array<Any> else{print("dataDailyArray did not unwrap"); return}
            
            for singleDictionary in dataDailyArray{
                
                guard let unwrappedSingleDictionary = singleDictionary as? [String: Any] else{print("dataDailySingleDictonary did not unwrap"); return}
                let dailyObject = DailyWeather.init(jsonDictionary: unwrappedSingleDictionary)
                
                self.dailyWeatherArray.append(dailyObject)
            }
            completion(self.currentWeatherArray, self.hourlyWeatherArray, self.dailyWeatherArray)
        }
    }
    
}
