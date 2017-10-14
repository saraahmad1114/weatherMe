//
//  GoogleCoordinateAPIClient.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/12/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import Foundation

class GoogleCoordinateAPIClient {
    
    class func getCoordinateInformation (zipCode: String, completion:@escaping([String: Any])->Void)
    
    {
        var jsonDictionary = [String: Any]()
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(zipCode)&key=\(Secrets.googleCoordinateApiKey)"
        
        let convertedUrl = URL(string: url)
        
        guard let unwrappedConvertedUrl = convertedUrl else {print("unwrappedConvertedUrl did not unwrap"); return}
        
        let request = URLRequest(url: unwrappedConvertedUrl)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("unwrappedData did not unwrap"); return}
            
            let json = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as? [String: Any]
            
            guard let unwrappedJson = json else {print("unwrappedJson did not unwrap"); return }
            
            guard let unwrappedJsonTwo = unwrappedJson else {print("unwrapped"); return}
            
            jsonDictionary = unwrappedJsonTwo
            
            completion(jsonDictionary)
        }
        task.resume()
    }
    
}
