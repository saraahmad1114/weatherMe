//
//  HourlyWeather.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//


import Foundation

struct HourlyWeather {

    var hourlyTime: Double?
    var hourlyTemperature: Double?
    var hourlyIcon: String?
    
    init(jsonDictionary: [String: Any]) {
        guard
            let time = jsonDictionary["time"] as? Double,
            let icon = jsonDictionary["icon"] as? String,
            let temperature = jsonDictionary["temperature"] as? Double
            else {print("did not unwrap hourlyWeather"); return}
        self.hourlyTime = time
        self.hourlyIcon = icon
        self.hourlyTemperature = temperature
    }
    
}
