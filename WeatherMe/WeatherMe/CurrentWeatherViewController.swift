//
//  CurrentWeatherViewController.swift
//  WeatherMe
//
//  Created by Flatiron School on 10/17/17.
//  Copyright © 2017 Flatiron School. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {
    
    var coordinateHolder: CLLocation?
    var zipCode: String?
    var currentVCGradientLayer: CAGradientLayer!
    let coordinateStore = CoordinatesDatastore.sharedInstance
    let weatherStore = WeatherForecastLocationDatastore.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
//        if self.coordinateHolder == nil {
//            self.coordinateStore.getUserCoordintes(zipcode:  unwrappedZipcode, completion: { (coordinates) in
//                guard let unwrappedLat = self.coordinateStore.locationCoordinates[0].latitude else{print("unwrapped lat"); return}
//                guard let unwrappedLng = self.coordinateStore.locationCoordinates[0].longitude else{print("unwrapped lng"); return}
//                self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (currentWeather, hourlyWeather, dailyWeather) in
//                    //OperationQueue.main.addOperation {
//                    //Need to update labels here!
//                    //}
//                })
//
//            })
//        }
        if self.coordinateHolder != nil {
            guard let unwrappedLat = self.coordinateHolder?.coordinate.latitude else {print("lat did not unwrap"); return}
            guard let unwrappedLng = self.coordinateHolder?.coordinate.longitude else{print("lng did not unwrap"); return}
            self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (current, hourly, daily) in
                //OperationQueue.main.addOperation {
                //Need to update labels here!
                //}
            })
        }
        else {
            guard let unwrappedZipcode = self.zipCode else {print("did not unwrap zipcode"); return}
            self.coordinateStore.getUserCoordintes(zipcode: unwrappedZipcode, completion: { (coordinatesJson) in
                print("********************")
                print(coordinatesJson)
                print("does this work")
                print("*******************")
                print(self.coordinateStore.locationCoordinates.first)
              
            })
            
        }
    }
    
    
    func createGradientLayer() {
    self.currentVCGradientLayer = CAGradientLayer()
    self.currentVCGradientLayer.frame = self.view.bounds
    self.currentVCGradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
    self.view.layer.addSublayer(self.currentVCGradientLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
