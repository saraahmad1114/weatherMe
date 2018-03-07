//
//  HourlyWeather.swift
//  WeatherMe
//


import Foundation

class HourlyWeather {

    var hourlyTime: Double?
    var hourlyTemperature: Double?
    var hourlyIcon: String?
    
    init(jsonDictionary: [String: Any]) {
        guard
            let time = jsonDictionary["time"] as? Double,
            let temperature = jsonDictionary["temperature"] as? Double,
            let icon = jsonDictionary["icon"] as? String
            else {print("did not unwrap hourlyWeather"); return}
        self.hourlyTime = time
        self.hourlyTemperature = temperature
        self.hourlyIcon = icon
    }
    
}
