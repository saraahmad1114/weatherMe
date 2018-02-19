//
//  DarkSkyAPIClient .swift
//  WeatherMe
//
//  Created by Flatiron School on 10/7/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class DarkSkyAPIClient {
    
    class func getWeatherInformation(lat: Double, lng: Double, completion:@escaping([String: Any])->()) {
        
        var jsonDictionary = [String: Any]()
        
        let url = "https://api.darksky.net/forecast/\(Secrets.darkSkyApiKey)/\(lat),\(-lng)"
        
        let convertedUrl = URL(string: url)
        
        guard let unwrappedUrl = convertedUrl else {print("unwrappedUrl did not unwrap"); return}
        
        let request = URLRequest(url: unwrappedUrl)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("data did not unwrap"); return}
            
            let jsonResponseDictionary = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
            
            guard let unwrappedJsonResponseDictionary = jsonResponseDictionary else {print("unwrappedJsonResponseDictionary did not unwrap"); return}
            
            jsonDictionary = unwrappedJsonResponseDictionary
            
            completion(jsonDictionary)
        }
        
        task.resume()
    
    }
    
    
}
