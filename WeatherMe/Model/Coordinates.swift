//
//  Coordinates.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/14/18.
//  Copyright © 2018 Sara Ahmad. All rights reserved.
//

import Foundation

//Definition of the Coordinate Object
class Coordinates{
    
    var latitude: Double?
    var longitude: Double?
    
    init(latitude: Double, longitude: Double){
        self.latitude = latitude
        self.longitude = longitude
    }
    
}

