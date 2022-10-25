//
//  SpesificLocationManager.swift
//  Animdo
//
//  Created by Pieter Venter on 2022/10/24.
//

import Foundation
import CoreLocation


class SpesificLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var Country: String?
    @Published var isoCode: String?
    @Published var Ocean: String?
    

    func get(longitude: Double, latitude: Double){
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        print(" done:\(location)")
        print(" done3:\(longitude)")
        print(" done4:\(latitude)")
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            print(" done again:\(location)")
            guard error == nil else {
                print("Reverse geocoder failed with error" + (error?.localizedDescription ?? ""))
                return
            }
            guard placemarks!.count > 0 else {
                print("Problem with the data received from geocoder")
                return
            }
            let pm = placemarks![0]
            
            self.Country = pm.country
            self.isoCode = pm.isoCountryCode
            self.Ocean = pm.ocean 
            print(pm.country as Any)
            print(pm.isoCountryCode as Any)
            print(pm.ocean as Any)

        })
    }
}



