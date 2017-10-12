//
//  HourlyWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class HourlyWeather {
    
    var hourlyTopsummary: String
    var hourlyTopIcon: String
    var hourlyTime: Double
    var hourlyBottomSummary: String
    var hourlyBottomIcon: String
    var hourlyPrecipProbability: Double
    var hourlyTemperature: Double
    var hourlyHumidity: Double
    var hourlyCloudCover: Double
    
    init(hourlyTopsummary: String, hourlyTopIcon: String, hourlyTime: Double, hourlyBottomSummary: String, hourlyBottomIcon: String, hourlyPrecipProbability: Double, hourlyTemperature: Double, hourlyHumidity: Double, hourlyCloudCover: Double ) {
        self.hourlyTopsummary = hourlyTopsummary
        self.hourlyTopIcon = hourlyTopIcon
        self.hourlyTime = hourlyTime
        self.hourlyBottomSummary = hourlyBottomSummary
        self.hourlyBottomIcon = hourlyBottomIcon
        self.hourlyPrecipProbability = hourlyPrecipProbability
        self.hourlyTemperature = hourlyTemperature
        self.hourlyHumidity = hourlyHumidity
        self.hourlyCloudCover = hourlyCloudCover
    }
    
}
