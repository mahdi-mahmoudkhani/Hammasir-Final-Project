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

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: LocationManager?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.locationManager = LocationManager()
        
        self.locationManager?.$authorization
            .sink { authorization in
                if authorization == .denied || authorization == .restricted || authorization == .none{
                    self.mapView.showsUserTrackingButton = false
                    
                } else {
                    self.mapView.showsUserTrackingButton = true
                    self.mapView.userTrackingMode = .follow
                }
            }
            .store(in: &self.cancellables)

    }
    

}
