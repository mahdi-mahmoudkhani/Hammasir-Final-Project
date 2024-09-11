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
    @IBOutlet weak var clearResultsButton: UIButton!
    
    private var locationManager: LocationManager?
    private var cancellables = Set<AnyCancellable>()
    
    var mapAnnotationManager: MapAnnotationManager?
    
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
    
    @IBAction func goToSearchView(_ sender: Any) {
        
        performSegue(withIdentifier: "GoToSearchView", sender: (self.mapView.userLocation.coordinate, self.addAnnotations))
    }
    
    @IBAction func clearResultsAnnotations(_ sender: Any) {
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.clearResultsButton.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let searchVC = segue.destination as? SearchViewController, let sender = sender as? (CLLocationCoordinate2D, ( (([SearchResult])) -> () )) {
            
            searchVC.userLocation = Location( x: sender.0.longitude,
                                         y: sender.0.latitude )
            
            searchVC.getBackResults = sender.1
            
            
        }

    }
    
    func addAnnotations(_ locations: [SearchResult]) {
        
        self.mapAnnotationManager = MapAnnotationManager()
        self.clearResultsButton.isHidden = false
        let annotations = mapAnnotationManager!.addAnnotation(at: locations)
        annotations.forEach { annotation in
            
            self.mapView.addAnnotation(annotation)
            
        }
        self.setMapRegionToIncludeAllResultsAnnotations()
        
    }
    
    func setMapRegionToIncludeAllResultsAnnotations() {
        
        var coordinates = self.mapView.annotations.map { $0.coordinate }
        
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count).boundingMapRect
        
        self.mapView.setVisibleMapRect(polygon, animated: true)
    }

}
