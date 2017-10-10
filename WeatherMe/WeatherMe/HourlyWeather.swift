//
//  HourlyWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class HourlyWeather {
    
    var time: Double
    var summary: String
    var icon: String
    var percipitationProbability: Double
    var temperature: Double
    var humidity: Double
    var cloudCover: Double
    
    init(time: Double, summary: String, icon: String, percipitationProbability: Double, temperature: Double, humidity: Double, cloudCover: Double) {
        self.time = time
        self.summary = summary
        self.icon = icon
        self.percipitationProbability = percipitationProbability
        self.temperature = temperature
        self.humidity = humidity
        self.cloudCover = cloudCover
    }
    
}
