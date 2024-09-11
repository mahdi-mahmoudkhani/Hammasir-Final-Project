//
//  MapViewController+Actions.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/22/1403 AP.
//

extension MapViewController {
    
    @IBAction func goToSearchView(_ sender: Any) {
        
        self.clearResultsAnnotations(())
        performSegue(withIdentifier: "GoToSearchView", sender: (self.mapView.userLocation.coordinate, self.addAnnotations))
    }
    
    @IBAction func clearResultsAnnotations(_ sender: Any) {
        
        self.mapView.removeAnnotations(self.mapView.annotations)
        self.clearResultsButton.isHidden = true
    }
    
}
