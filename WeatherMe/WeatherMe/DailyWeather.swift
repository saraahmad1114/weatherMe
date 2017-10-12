//
//  DailyWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class DailyWeather {
    
    var dailyTopSummary: String
    var dailyTopIcon: String
    var dailyTime: Double
    var dailyBottomSummary: String
    var dailyBottomIcon: String
    var dailyPrecipProbability: Double
    var dailyTemperatureHigh: Double
    var dailyTemperatureLow: Double
    var dailyHumidity: Double
    var dailyCloudCover: Double
    
    init(dailyTopSummary: String, dailyTopIcon: String, dailyTime: Double, dailyBottomSummary: String, dailyBottomIcon: String, dailyPrecipProbability: Double, dailyTemperatureHigh: Double, dailyTemperatureLow: Double, dailyHumidity: Double, dailyCloudCover: Double) {
        
        self.dailyTopSummary = dailyTopSummary
        self.dailyTopIcon = dailyTopIcon
        self.dailyTime = dailyTime
        self.dailyBottomSummary = dailyBottomSummary
        self.dailyBottomIcon = dailyBottomIcon
        self.dailyPrecipProbability = dailyPrecipProbability
        self.dailyTemperatureHigh = dailyTemperatureHigh
        self.dailyTemperatureLow = dailyTemperatureLow
        self.dailyHumidity = dailyHumidity
        self.dailyCloudCover = dailyCloudCover
    }
    
}
