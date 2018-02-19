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
    
    func getWeatherForecastInformation(lat: Double, lng: Double, completion:@escaping ([CurrentWeather]) -> ()){
        
        var newLng = -1 * lng
        
        DarkSkyAPIClient.getWeatherInformation(lat: lat, lng: newLng) { (darkSkyJson) in
                        
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
            
            guard let visibility = currentDictionary["visibility"] as? Double else{print("did not unwrap currentVisibility"); return}
            
            guard let ozone = currentDictionary["ozone"] as? Double else{print("did not unwrap currentOzone"); return}
            
            let currentWeatherForecastObj = CurrentWeather.init(currentSummary: summary, currentIcon: icon, currentPrecipProbability: precipProb, currentTemperature: temperature, currentDewPoint: dewPoint, currentHumidity: humidity, currentPressure: pressure, currentWindSpeed: windSpeed, currentCloudCover: cloudCover, currentUVIndex: uVIndex, currentVisibility: visibility, currentOzone: ozone)
            
            print("******************************")
            print(currentWeatherForecastObj.currentSummary)
            print(currentWeatherForecastObj.currentIcon)
            print(currentWeatherForecastObj.currentPrecipProbability)
            print(currentWeatherForecastObj.currentTemperature)
            print(currentWeatherForecastObj.currentDewPoint)
            print(currentWeatherForecastObj.currentHumidity)
            print(currentWeatherForecastObj.currentPressure)
            print(currentWeatherForecastObj.currentWindSpeed)
            print(currentWeatherForecastObj.currentCloudCover)
            print(currentWeatherForecastObj.currentUVIndex)
            print(currentWeatherForecastObj.currentVisibility)
            print(currentWeatherForecastObj.currentOzone)
            print("******************************")
            
            self.currentWeatherArray.append(currentWeatherForecastObj)
        }
        completion(self.currentWeatherArray)
    }
    
}
