//
//  GoogleCoordinateAPIClient.swift
//  WeatherMe
//

//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//


import Foundation

//MARK: TO DO LIST:
//1. install cocoapod
//2. progress spinner
//3. add to the project 

class GoogleCoordinateAPIClient {
    
    class func getCoordinateInformation (zipCode: String, completion:@escaping([String: Any])->()) throws {
        let zipCode = zipCode.replacingOccurrences(of: " ", with: "+")
        var jsonDictionary = [String: Any]()
        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(zipCode)&key=\(Secrets.googleCoordinateApiKey)"
        let convertedUrl = URL(string: url)
        guard let unwrappedConvertedUrl = convertedUrl else {print("unwrappedConvertedUrl did not unwrap"); return}
        let request = URLRequest(url: unwrappedConvertedUrl)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let unwrappedData = data else {print("unwrappedData did not unwrap"); return}
            do{
            let json = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
            jsonDictionary = json
            completion(jsonDictionary)
            }
            catch let error{
                print("Error message is: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    class func isAddressValid (zipCode: String, completion:@escaping(Bool)->()){
        let zipCode = zipCode.replacingOccurrences(of: " ", with: "+")
        var isAddressValid = Bool()
        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(zipCode)&key=\(Secrets.googleCoordinateApiKey)"
        let convertedUrl = URL(string: url)
        guard let unwrappedConvertedUrl = convertedUrl else {print("unwrappedConvertedUrl did not unwrap"); return}
        let request = URLRequest(url: unwrappedConvertedUrl)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let unwrappedData = data else {print("unwrappedData did not unwrap"); return}
            guard let httpResponse = response as? HTTPURLResponse else{print("httpResponse did not unwrap"); return}
            if httpResponse.statusCode == 200 {
                isAddressValid = true
            }
            else if httpResponse.statusCode != 200 {
                isAddressValid = false
            }
            completion(isAddressValid)
        }
        task.resume()
    }
    
}
