//
//  MapViewController.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/19/1403 AP.
//

import UIKit
import MapKit
import Combine

class MapViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var clearResultsButton: UIButton!
    
    // MARK: - Stored Properties
    
    private var locationManager: LocationManager?
    private var cancellables = Set<AnyCancellable>()
    
    var mapAnnotationManager: MapAnnotationManager?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.locationManager = LocationManager()
        
        self.locationManager?.$authorization
            .sink { authorization in
                
                if authorization == .denied || authorization == .restricted || authorization == .none {
                    
                    self.mapView.showsUserTrackingButton = false
                    
                } else {
                    
                    self.mapView.showsUserTrackingButton = true
                    self.mapView.userTrackingMode = .follow
                }
            }
            .store(in: &self.cancellables)

    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let searchVC = segue.destination as? SearchViewController, let sender = sender as? (CLLocationCoordinate2D, ( (([SearchResult])) -> () )) {
            
            searchVC.userLocation = Location( x: sender.0.longitude, y: sender.0.latitude )
            searchVC.getBackResults = sender.1
        }
    }

}
