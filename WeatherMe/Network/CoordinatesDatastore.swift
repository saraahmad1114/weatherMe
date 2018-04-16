//
//  CoordinatesDatastore.swift
//  WeatherMe
//

//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//


import Foundation

class CoordinatesDatastore {
    
    static let sharedInstance = CoordinatesDatastore()
    private init() {}
    
    //var locationCoordinates = [Coordinates]()
    
    //Getting JSON and creating the Swift Object 
    func getUserCoordintes (zipcode: String, completion:@escaping ([Coordinates]) -> ()) throws {
        var locationCoordinates = [Coordinates]()
        do {
            try GoogleCoordinateAPIClient.getCoordinateInformation(zipCode: zipcode) { (googleAPICoordinatesJson) in
            guard let secondLevelArray = googleAPICoordinatesJson["results"] as? Array<Any> else {print("did not unwrap at the second level"); return}
            guard let firstElementFromArray = secondLevelArray[0] as? [String : Any] else {print("did not unwrap at the third level"); return}
            guard let geometryDictionary = firstElementFromArray["geometry"] as? [String: Any] else {print("did not unwrap at the fourth level"); return}
            guard let locationDictionary = geometryDictionary["location"] as? [String: Any] else {print("did not unwrap at the fifth level"); return}
            guard let locationLat = locationDictionary["lat"] as? Double else {print("did not unwrap latitude"); return}
            guard let locationLng = locationDictionary["lng"] as? Double else {print("did not unwrap longitude"); return}
            let coordinatesObject = Coordinates.init(latitude: locationLat, longitude: locationLng)
            locationCoordinates.append(coordinatesObject)
            completion(locationCoordinates)
            }
        }
        catch let error {
            print("error now is: \(error.localizedDescription)")
        }
    }
    
}
