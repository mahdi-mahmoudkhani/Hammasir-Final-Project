//
//  MapAnnotationManager.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/21/1403 AP.
//

import MapKit

class MapAnnotationManager {
    
    func addAnnotation(at location: [SearchResult]) -> [MKPointAnnotation] {
        
        var finalAnnotations = [MKPointAnnotation]()
        
        location.forEach { location in
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.location.y, longitude: location.location.x)
            annotation.title = location.title
            finalAnnotations.append(annotation)
        
        }
        
        return finalAnnotations
    }
}
