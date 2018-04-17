//
//  Coordinates.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//

import Foundation

struct Coordinates{
    
    var latitude: Double?
    var longitude: Double?
    var locationName: String
    
//    init(latitude: Double, longitude: Double){
//        self.latitude = latitude
//        self.longitude = longitude
//    }
    init(latitude: Double, longitude: Double, locationName: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.locationName = locationName
    }
    
}

