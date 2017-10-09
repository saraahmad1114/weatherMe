//
//  CurrentWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class CurrentWeather {
    
    var time: Double
    var summary: String
    var icon: String
    var precipitationProbability: Double
    var temperature: Double
    var humidity: Double
    var cloudCover: Double
    var timeZone: String
    
    init(time: Double, summary: String, icon: String, precipitationProbability: Double, temperature: Double, humidity: Double, cloudCover: Double, timeZone: String) {
        self.time = time
        self.summary = summary
        self.icon = icon
        self.precipitationProbability = precipitationProbability
        self.temperature = temperature
        self.humidity = humidity
        self.cloudCover = cloudCover
        self.timeZone = timeZone
    }
    
    
}
