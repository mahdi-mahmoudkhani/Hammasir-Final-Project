//
//  SearchViewController+Actions.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/22/1403 AP.
//

import UIKit

extension SearchViewController {
    
    @IBAction func dismissView(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func SearchButtonTapped(_ sender: Any) {
        
        self.areSavedResultsLoaded = false
        guard let query = searchField.text else { return }
        
        Task {
            do {
                let response = try await self.searchService.search(for: query, around: userLocation!)
                self.searchResults = response.items
                self.tableView.reloadData()
            } catch {
                print("Error: \(error)")
            }
            
        }
    }
    
    @IBAction func showOnMap(_ sender: Any) {
        
        self.getBackResults?(self.searchResults)
        self.dismiss(animated: true)
    }
}
