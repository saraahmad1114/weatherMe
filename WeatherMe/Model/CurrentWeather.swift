//
//  CurrentWeather.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//

import Foundation

//Definition of the CurrentWeather Object
class CurrentWeather {
    var timeZone: String?
    var time: Double?
    var summary: String?
    var icon: String?
    var temperature: Double?
    var precipProbability: Double?
    var humidity: Double?
    var windSpeed: Double?
    
    init(timeZone: String, time: Double, summary: String, icon: String, temperature: Double, precipProbability: Double, humidity: Double, windSpeed: Double) {
        self.timeZone = timeZone
        self.time = time
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        self.precipProbability = precipProbability
        self.humidity = humidity
        self.windSpeed = windSpeed
    }
    
}
