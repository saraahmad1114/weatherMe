//
//  CurrentWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    var currentSummary: String?
    var currentIcon: String?
    var currentPrecipProbability: Double?
    var currentTemperature: Double?
    var currentDewPoint: Double?
    var currentHumidity: Double?
    var currentPressure: Double?
    var currentWindSpeed: Double?
    var currentCloudCover: Double?
    var currentUVIndex: Double?
    var currentVisibility: Double?
    var currentOzone: Double?
    
    init(jsonDictionary: [String: Any]) {
        guard
        let currentSummary = jsonDictionary["summary"] as? String,
        let currentIcon = jsonDictionary["icon"] as? String,
        let currentPrecipProbability = jsonDictionary["precipProbability"] as? Double,
        let currentTemperature = jsonDictionary["temperature"] as? Double,
        let currentDewPoint = jsonDictionary["dewPoint"] as? Double,
        let currentHumidity = jsonDictionary["humidity"] as? Double,
        let currentPressure = jsonDictionary["pressure"] as? Double,
        let currentWindSpeed = jsonDictionary["windSpeed"] as? Double,
        let currentCloudCover = jsonDictionary["cloudCover"] as? Double,
        let currentUVIndex = jsonDictionary["uvIndex"] as? Double,
        let currentVisibility = jsonDictionary["visibility"] as? Double,
        let currentOzone = jsonDictionary["ozone"] as? Double
        
            else {print("did not unwrap currentWeather information"); return}
        
        self.currentSummary = currentSummary
        self.currentIcon = currentIcon
        self.currentPrecipProbability = currentPrecipProbability
        self.currentTemperature = currentTemperature
        self.currentDewPoint = currentDewPoint
        self.currentHumidity = currentHumidity
        self.currentPressure = currentPressure
        self.currentWindSpeed = currentWindSpeed
        self.currentCloudCover = currentCloudCover
        self.currentUVIndex = currentUVIndex
        self.currentVisibility = currentVisibility
        self.currentOzone = currentOzone
    }

    
}
