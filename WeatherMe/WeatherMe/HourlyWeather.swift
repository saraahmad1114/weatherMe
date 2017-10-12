//
//  HourlyWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class HourlyWeather {
    
    var summary: String
    var icon: String
    var time: Double
    var dailySummary: String
    var dailyIcon: String
    var precipProbability: Double
    var temperature: Double
    var humidity: Double
    var cloudCover: Double
    
    init(summary: String, icon: String, time: Double, dailySummary: String, dailyIcon: String, precipProbability: Double, temperature: Double, humidity: Double, cloudCover: Double ) {
        self.summary = summary
        self.icon = icon
        self.time = time
        self.dailySummary = dailySummary
        self.dailyIcon = dailyIcon
        self.precipProbability = precipProbability
        self.temperature = temperature
        self.humidity = humidity
        self.cloudCover = cloudCover
    }
    
}
