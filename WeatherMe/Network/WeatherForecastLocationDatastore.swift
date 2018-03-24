//
//  WeatherForecastLocationDatastore.swift
//  WeatherMe
//

import Foundation

class WeatherForecastLocationDatastore{

    static let sharedInstance = WeatherForecastLocationDatastore()
    private init() {}
    
    var currentWeatherArray = [CurrentWeather]()
    var hourlyWeatherArray = [HourlyWeather]()
    var dailyWeatherArray = [DailyWeather]()
    
    func getWeatherForecastInformation(lat: Double, lng: Double, completion:@escaping ([CurrentWeather], [HourlyWeather], [DailyWeather]) -> ()) throws{
        
        do{
        
            try DarkSkyAPIClient.getWeatherInformation(lat: lat, lng: -lng) { (darkSkyJson) in
            
            guard let jsonDictionary = darkSkyJson as? [String: Any] else {print("first level dictionary did not unwrap"); return}
            
            guard let timeZone = jsonDictionary["timezone"] as? String else {print("timeZone did not unwrap"); return}
            
            guard let currentDictionary = jsonDictionary["currently"] as? [String: Any] else{print("did not unwrap currentDictionary did not unwrap"); return}
            
            guard let time = currentDictionary["time"] as? Double else{print("time did not unwrap"); return}
            
            guard let summary = currentDictionary["summary"] as? String else {print("did not unwrap currentSummary"); return}
            
            guard let icon = currentDictionary["icon"] as? String else {print("did not unwrap currentIcon"); return}
            
            guard let precipProb = currentDictionary["precipProbability"] as? Double else{print("did not unwrap currentPrecipProbability"); return}
            
            guard let temperature = currentDictionary["temperature"] as? Double else{print("did not unwrap currentTemperature"); return}
            
            guard let humidity = currentDictionary["humidity"] as? Double else{print("did not unwrap currentHumidity"); return}
            
            guard let windSpeed = currentDictionary["windSpeed"] as? Double else{print("did not unwrap currentWindSpeed"); return}
            
            let currentWeatherForecastObj = CurrentWeather.init(timeZone: timeZone, time: time, summary: summary, icon: icon, temperature: temperature, precipProbability: precipProb, humidity: humidity, windSpeed: windSpeed)
            
            self.currentWeatherArray.append(currentWeatherForecastObj)

            guard let hourlyDictionary = darkSkyJson["hourly"] as? [String: Any] else{print("did not unwrap hourlyDictionary"); return}

            guard let dataArray = hourlyDictionary["data"] as? Array<Any> else{print("did not unwrap dataArray"); return}
            
            for singleDictionary in dataArray{
                guard let unwrappedSingleDictionary = singleDictionary as? [String: Any] else{print("singleDictionary did not unwrap"); return}
                let hourlyForecastObj = HourlyWeather.init(jsonDictionary: unwrappedSingleDictionary)
                
                self.hourlyWeatherArray.append(hourlyForecastObj)
            }
            
            guard let dailyDictionary = jsonDictionary["daily"] as? [String: Any] else{print("dailyDictionary did not unwrap"); return}
            
            guard let dataDailyArray = dailyDictionary["data"] as? Array<Any> else{print("dataDailyArray did not unwrap"); return}
            
            for singleDictionary in dataDailyArray{
                
                guard let unwrappedSingleDictionary = singleDictionary as? [String: Any] else{print("dataDailySingleDictonary did not unwrap"); return}
                let dailyObject = DailyWeather.init(jsonDictionary: unwrappedSingleDictionary)
                
                self.dailyWeatherArray.append(dailyObject)
            }
            completion(self.currentWeatherArray, self.hourlyWeatherArray, self.dailyWeatherArray)
            }
        }
        catch let error {
            print("error loal description is: \(error.localizedDescription)")
        }
    }
    
}
