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
    var icon: String
    var summary: String
    var hourlyIcon: String
    var percipitationProbability: Double
    var temperature: Double
    var humidity: Double
    var cloudCover: Double
    var overallSummary: String
    
    init(time: Double, icon: String, summary: String, hourlyIcon: String, percipitationProbability: Double, temperature: Double, humidity: Double, cloudCover: Double, overallSummary: String) {
        self.time = time
        self.icon = icon
        self.summary = summary
        self.hourlyIcon = hourlyIcon
        self.percipitationProbability = percipitationProbability
        self.temperature = temperature
        self.humidity = humidity
        self.cloudCover = cloudCover
        self.overallSummary = overallSummary
    }
    
}
