//
//  CoordinatesDatastore.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 2/15/18.
//  Copyright © 2018 Flatiron School. All rights reserved.
//

import Foundation

class CoordinatesDatastore {
    
    static let sharedInstance = CoordinatesDatastore()
    private init() {}
    
    var locationCoordinates = [Coordinates]()
    
    func getUserCoordintes (zipcode: String, completion:@escaping ([Coordinates]) -> ()){
        GoogleCoordinateAPIClient.getCoordinateInformation(zipCode: zipcode) { (googleAPICoordinatesJson) in
            
//            guard let unwrappedJson
//                = googleAPICoordinatesJson as? [String: Any] else {print("did not unwrap at the first level"); return}
            
            guard let secondLevelArray = googleAPICoordinatesJson["results"] as? Array<Any> else {print("did not unwrap at the second level"); return}
            
            guard let firstElementFromArray = secondLevelArray[0] as? [String : Any] else {print("did not unwrap at the third level"); return}
            
            guard let geometryDictionary = firstElementFromArray["geometry"] as? [String: Any] else {print("did not unwrap at the fourth level"); return}
            
            guard let locationDictionary = geometryDictionary["location"] as? [String: Any] else {print("did not unwrap at the fifth level"); return}
            
            guard let locationLat = locationDictionary["lat"] as? Double else {print("did not unwrap latitude"); return}
            guard let locationLng = locationDictionary["lng"] as? Double else {print("did not unwrap longitude"); return}
            
            let coordinatesObject = Coordinates.init(latitude: locationLat, longitude: locationLng)
                        
            self.locationCoordinates.append(coordinatesObject)
            completion(self.locationCoordinates)
        }
    }
    
}
