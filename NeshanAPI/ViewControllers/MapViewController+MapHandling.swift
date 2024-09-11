//
//  MapViewController+MapHandling.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/22/1403 AP.
//

import MapKit

extension MapViewController {
    
    func addAnnotations(_ locations: [SearchResult]) {
        
        self.mapAnnotationManager = MapAnnotationManager()
        self.clearResultsButton.isHidden = false
        let annotations = self.mapAnnotationManager!.addAnnotation(at: locations)
        
        annotations.forEach { annotation in
            
            self.mapView.addAnnotation(annotation)
            
        }
        
        self.setMapRegionToIncludeAllResultsAnnotations()
        
    }
    
    func setMapRegionToIncludeAllResultsAnnotations() {
        
        let coordinates = self.mapView.annotations.map { $0.coordinate }
        
        let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count).boundingMapRect
        
        self.mapView.setVisibleMapRect(polygon, animated: true)
    }

}
