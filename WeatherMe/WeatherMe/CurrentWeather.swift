//
//  CurrentWeather.swift
//  WeatherMe
//


import Foundation

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
