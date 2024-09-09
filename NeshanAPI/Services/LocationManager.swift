//
//  LocationManager.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/19/1403 AP.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var authorization: CLAuthorizationStatus?
    private var locationManager: CLLocationManager?
    
    override init() {
        
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
    }
    
    private func checkLocationAuthorization() {
        
        guard let locationManager = self.locationManager else { return }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("Show an allert to let them know")
            
        case .denied:
            print("Show an allert to let them turn it on")
            
        case .authorizedAlways, .authorizedWhenInUse:
            self.authorization = .authorizedWhenInUse
            
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        self.checkLocationAuthorization()
    }

}
