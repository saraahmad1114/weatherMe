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
    let coordinateStore = CoordinatesDatastore.sharedInstance
    let weatherStore = WeatherForecastLocationDatastore.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        if self.coordinateHolder != nil {
            //core location
            guard let unwrappedLat = self.coordinateHolder?.coordinate.latitude else {print("lat did not unwrap"); return}
            guard let unwrappedLng = self.coordinateHolder?.coordinate.longitude else{print("lng did not unwrap"); return}
            self.weatherStore.getWeatherForecastInformation(lat: unwrappedLat, lng: unwrappedLng, completion: { (current, hourly, daily) in
                OperationQueue.main.addOperation {
                    print("**************CURRENT*******************")
                    print(current)
                    print("**************CURRENT*******************")
                    
                    print("**************HOURLY*******************")
                    print(hourly)
                    print("**************HOURLY*******************")
                    
                    print("**************DAILY*******************")
                    print(daily)
                    print("**************DAILY*******************")
                }
            })
        }
        else {
            //zip code
            guard let unwrappedZipcode = self.zipCode else {print("did not unwrap zipcode"); return}
            self.coordinateStore.getUserCoordintes(zipcode: unwrappedZipcode, completion: { (coordinatesJson) in
                
                guard let lat = self.coordinateStore.locationCoordinates.first?.latitude else{print("did not unwrap lat"); return}
                guard let lng = self.coordinateStore.locationCoordinates.first?.longitude else{print("did not unwrap lng"); return}
                
                self.weatherStore.getWeatherForecastInformation(lat: lat, lng: lng, completion: { (current, hourly, daily) in
                    OperationQueue.main.addOperation {
                        
                        print("**************CURRENT*******************")
                        print(current)
                        print("**************CURRENT*******************")

                        print("**************HOURLY*******************")
                        print(hourly)
                        print("**************HOURLY*******************")
                        
                        print("**************DAILY*******************")
                        print(daily)
                        print("**************DAILY*******************")
                    }
                   
                })

            })
            
        }
    }
    
    
    func createGradientLayer() {
        var gradientLayer: CAGradientLayer!
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.cyan.cgColor]
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
    
    
    //SAVE THE FOLLOWING FUNCTIONS 
    
    //prints the following: "Mar 1, 2018 at 4:00:00 PM"
    //HELPS TO GET THE HOURS DOWN
    func convertTimestampHour (givenTime: Double) -> String {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
        dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    //prints out Thursday - gets the day of the week
    func dayOfWeek(givenTime: Double) -> String? {
        let date = Date(timeIntervalSince1970: givenTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
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
