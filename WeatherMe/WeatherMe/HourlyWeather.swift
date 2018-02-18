//
//  HourlyWeather.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/9/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class HourlyWeather {

    var hourlyTime: Double?
    var hourlyTemperature: Double?
    
    init(jsonDictionary: [String: Any]) {
        guard
            let time = jsonDictionary["time"] as? Double,
            let temperature = jsonDictionary["temperature"] as? Double
            else {print("did not unwrap hourlyWeather"); return}
        
        self.hourlyTime = time
        self.hourlyTemperature = temperature
    }
    
}
