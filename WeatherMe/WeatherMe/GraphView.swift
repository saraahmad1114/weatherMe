//
//  GraphView.swift
//  WeatherMe
//
//  Created by Sara Ahmad on 3/6/18.
//  Copyright © 2018 Flatiron School. All rights reserved.
//

import UIKit

private struct Constants {
    static let cornerRadiusSize = CGSize(width: 8.0, height: 8.0)
    static let margin: CGFloat = 20.0
    static let topBorder: CGFloat = 60
    static let bottomBorder: CGFloat = 50
    static let colorAlpha: CGFloat = 0.3
    static let circleDiameter: CGFloat = 5.0
}


@IBDesignable class GraphView: UIView {
    
    var yAxisValues = [HourlyWeather]()
    let weatherStore = WeatherForecastLocationDatastore.sharedInstance

    // 1
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: Constants.cornerRadiusSize)
        path.addClip()
        
        // 2
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        // 3
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 4
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        // 5
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        // 6
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    }
    
    //Cast temperature as Ints -- Temperature go here:
    func createYAxis() -> [Int]{
        var displayTemperatures = [Int]()
        for singleHour in self.weatherStore.hourlyWeatherArray{
            if let unwrappedHour = singleHour.hourlyTemperature{
            displayTemperatures.append(Int(unwrappedHour))
            }
        }
        return displayTemperatures
    }
    
//    //cast hours as Strings --
//    func createXAxis() -> [Int]{
//
//    }
}
