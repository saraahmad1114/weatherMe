//
//  GoogleCoordinateAPIClient.swift
//  WeatherMe
//


import Foundation

class GoogleCoordinateAPIClient {
    
    //fix the api client to handle error, so the app doesn't crash
    
    //don't forget to include a do and catch == Error handling so that the app doesn't crash 
    
    class func getCoordinateInformation (zipCode: String, completion:@escaping([String: Any])->()){

        var jsonDictionary = [String: Any]()

        let url = "https://maps.googleapis.com/maps/api/geocode/json?address=\(zipCode)&key=\(Secrets.googleCoordinateApiKey)"
        
        let convertedUrl = URL(string: url)
        
        guard let unwrappedConvertedUrl = convertedUrl else {print("unwrappedConvertedUrl did not unwrap"); return}
        
        let request = URLRequest(url: unwrappedConvertedUrl)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let unwrappedData = data else {print("unwrappedData did not unwrap"); return}
            
            let json = try? JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [String: Any]
            
            guard let unwrappedJson = json else {print("unwrappedJson did not unwrap"); return }
            
            jsonDictionary = unwrappedJson
            
            completion(jsonDictionary)
        }
        task.resume()
    }
    
}
