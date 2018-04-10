//
//  DarkSkyAPIClient .swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//


import Foundation

class DarkSkyAPIClient {
    
    //Function to get JSON
    class func getWeatherInformation(lat: Double, lng: Double, completion:@escaping([String: Any])->()) throws {
        var jsonDictionary = [String: Any]()
        let url = "https://api.darksky.net/forecast/\(Secrets.darkSkyApiKey)/\(lat),\(-lng)"
        let convertedUrl = URL(string: url)
        guard let unwrappedUrl = convertedUrl else {print("unwrappedUrl did not unwrap"); return}
        let request = URLRequest(url: unwrappedUrl)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let unwrappedData = data else {print("data did not unwrap"); return}
            do{
            let jsonResponseDictionary = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
            jsonDictionary = jsonResponseDictionary
            completion(jsonDictionary)
            }
            catch let error{
                print("error getting back json: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
