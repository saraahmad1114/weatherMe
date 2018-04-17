//
//  DailyWeather.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//

import Foundation=

//Definition of the HourlyWeather Object
struct DailyWeather{
    
    var dailyTime: Double?
    var dailyTemperatureHigh: Double?
    var dailyTemperatureLow: Double?
    var dailyIcon: String?
    
    init(jsonDictionary: [String: Any]) {
        guard
            let time = jsonDictionary["time"] as? Double,
            let temperatureHigh = jsonDictionary["temperatureHigh"] as? Double,
            let temperatureLow = jsonDictionary["temperatureLow"] as? Double,
            let icon = jsonDictionary["icon"] as? String
            else{print("did not unwrap dailyWeatherJson"); return}
        
        self.dailyTime = time
        self.dailyTemperatureHigh = temperatureHigh
        self.dailyTemperatureLow = temperatureLow
        self.dailyIcon = icon
    }
    
}
