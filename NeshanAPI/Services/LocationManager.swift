//
//  LocationManager.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/19/1403 AP.
//

import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // MARK: - Published Properties
    
    @Published var authorization: CLAuthorizationStatus?
    
    // MARK: - Stored Properties
    
    private var locationManager: CLLocationManager?
    
    // MARK: - Initialization
    
    override init() {
        
        super.init()
        self.locationManager = CLLocationManager()
        self.locationManager!.delegate = self
    }
    
    // MARK: - Helper Methods
    
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
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        self.checkLocationAuthorization()
    }

}
