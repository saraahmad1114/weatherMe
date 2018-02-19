//
//  WeatherForecastLocationDatastore.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 2/19/18.
//  Copyright © 2018 Flatiron School. All rights reserved.
//

import Foundation

class WeatherForecastLocationDatastore{

    static let sharedInstance = WeatherForecastLocationDatastore()
    private init() {}
    
    var currentWeatherArray = [CurrentWeather]()
    
    func getWeatherForecastInformation(lat: Double, lng: Double, completion:@escaping ([CurrentWeather]) -> ()){
        
    } 
    
}
