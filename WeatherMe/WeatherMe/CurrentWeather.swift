//
//  CurrentWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    var currentTime: Double
    var currentSummary: String
    var currentIcon: String
    var currentPrecipitationProbability: Double
    var currentTemperature: Double
    var currentHumidity: Double
    var currentCloudCover: Double
    var currentTimezone: String
    
    init(currentTime: Double, currentSummary: String, currentIcon: String, currentPrecipitationProbability: Double, currentTemperature: Double, currentHumidity: Double, currentCloudCover: Double, currentTimezone: String) {
        
        self.currentTime = currentTime
        self.currentSummary = currentSummary
        self.currentIcon = currentIcon
        self.currentPrecipitationProbability = currentPrecipitationProbability
        self.currentTemperature = currentTemperature
        self.currentHumidity = currentHumidity
        self.currentCloudCover = currentCloudCover
        self.currentTimezone = currentTimezone
    }
    
}
