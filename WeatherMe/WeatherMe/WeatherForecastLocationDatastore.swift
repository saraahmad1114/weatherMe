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
    var hourlyWeatherArray = [HourlyWeather]()
    
    func getWeatherForecastInformation(lat: Double, lng: Double, completion:@escaping ([CurrentWeather], [HourlyWeather]) -> ()){
        
        let newLng = -1 * lng
        
        DarkSkyAPIClient.getWeatherInformation(lat: lat, lng: newLng) { (darkSkyJson) in
            
            guard let jsonDictionary = darkSkyJson as? [String: Any] else {print("first level dictionary did not unwrap"); return}
            
            guard let currentDictionary = jsonDictionary["currently"] as? [String: Any] else{print("did not unwrap currentDictionary did not unwrap"); return}
            
            guard let summary = currentDictionary["summary"] as? String else {print("did not unwrap currentSummary"); return}
            
            guard let icon = currentDictionary["icon"] as? String else {print("did not unwrap currentIcon"); return}
            
            guard let precipProb = currentDictionary["precipProbability"] as? Double else{print("did not unwrap currentPrecipProbability"); return}
            
            guard let temperature = currentDictionary["temperature"] as? Double else{print("did not unwrap currentTemperature"); return}
            
            guard let dewPoint = currentDictionary["dewPoint"] as? Double else{print("did not unwrap currentDewPoint"); return}
            
            guard let humidity = currentDictionary["humidity"] as? Double else{print("did not unwrap currentHumidity"); return}
            
            guard let pressure = currentDictionary["pressure"] as? Double else{print("did not unwrap currentPressue"); return}
            
            guard let windSpeed = currentDictionary["windSpeed"] as? Double else{print("did not unwrap currentWindSpeed"); return}
            
            guard let cloudCover = currentDictionary["cloudCover"] as? Double else{print("did not unwrap currentCloudCover"); return}
            
            guard let uVIndex = currentDictionary["uvIndex"] as? Double else{print("did not unwrap currentUVIndex"); return}
            
            guard let visibility = currentDictionary["visibility"] as? Double else{print("did not unwrap currentVisibility"); return}
            
            guard let ozone = currentDictionary["ozone"] as? Double else{print("did not unwrap currentOzone"); return}
            
            //Current Weather forecast Object
            let currentWeatherForecastObj = CurrentWeather.init(currentSummary: summary, currentIcon: icon, currentPrecipProbability: precipProb, currentTemperature: temperature, currentDewPoint: dewPoint, currentHumidity: humidity, currentPressure: pressure, currentWindSpeed: windSpeed, currentCloudCover: cloudCover, currentUVIndex: uVIndex, currentVisibility: visibility, currentOzone: ozone)
            
            self.currentWeatherArray.append(currentWeatherForecastObj)
            
            print(self.currentWeatherArray.count)
            
            print("*********************************")
            print(self.currentWeatherArray.first?.currentSummary)
            print(self.currentWeatherArray.first?.currentIcon)
            print(self.currentWeatherArray.first?.currentPrecipProbability)
            print(self.currentWeatherArray.first?.currentTemperature)
            print(self.currentWeatherArray.first?.currentDewPoint)
            print(self.currentWeatherArray.first?.currentHumidity)
            print(self.currentWeatherArray.first?.currentPressure)
            print(self.currentWeatherArray.first?.currentWindSpeed)
            print(self.currentWeatherArray.first?.currentCloudCover)
            print(self.currentWeatherArray.first?.currentUVIndex)
            print(self.currentWeatherArray.first?.currentVisibility)
            print(self.currentWeatherArray.first?.currentOzone)
            print("*********************************")

            guard let hourlyDictionary = darkSkyJson["hourly"] as? [String: Any] else{print("did not unwrap hourlyDictionary"); return}

            guard let dataArray = hourlyDictionary["data"] as? Array<Any> else{print("did not unwrap dataArray"); return}

            for singleDictionary in dataArray{

                guard let unwrappedSingleDictionary = singleDictionary as? [String: Any] else{print("singleDictionary did not unwrap"); return}

                let hourlyForecastObj = HourlyWeather.init(jsonDictionary: unwrappedSingleDictionary)

                self.hourlyWeatherArray.append(hourlyForecastObj)

                print(self.hourlyWeatherArray.count)

                print("************************")
                print(hourlyForecastObj.hourlyTime)
                print(hourlyForecastObj.hourlyTemperature)
                print("************************")

            }

        }
        completion(self.currentWeatherArray, self.hourlyWeatherArray)
    }
    
}
