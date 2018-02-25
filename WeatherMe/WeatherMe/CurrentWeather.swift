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
    
    var currentOzone: Double?
    
    init(currentSummary: String,currentIcon: String, currentPrecipProbability: Double, currentTemperature: Double, currentDewPoint: Double, currentHumidity: Double, currentPressure: Double, currentWindSpeed: Double, currentCloudCover: Double, currentUVIndex: Double, currentOzone: Double ) {
        
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
        self.currentOzone = currentOzone
    }

    
}
