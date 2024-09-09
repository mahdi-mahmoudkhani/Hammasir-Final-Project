//
//  LocationManager.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/19/1403 AP.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    private let locationManager =  CLLocationManager()
    
    override init() {
        
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
}
