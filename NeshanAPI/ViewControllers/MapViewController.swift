//
//  MapViewController.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/19/1403 AP.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private var locationManager: LocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.mapView.userTrackingMode = .follow
        self.locationManager = LocationManager()
    }
    

}
