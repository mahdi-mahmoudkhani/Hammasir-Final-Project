//
//  SearchViewController+TableHandling.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/22/1403 AP.
//

import UIKit

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfResults = self.searchResults.count
        self.showOnMapButton.isEnabled = numberOfResults != 0
        
        return numberOfResults
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") else {
            
            return UITableViewCell()
        }
        
        cell.textLabel?.text = self.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = self.searchResults[indexPath.row].address
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if self.areSavedResultsLoaded! {
            
            return nil
        }
        
        let saveAction = UIContextualAction(style: .normal, title: "Save") { action, view, completionHandler in
            
            self.searchPersistence.appendSavedResults([self.searchResults[indexPath.row]])
            completionHandler(true)
        }
        
        saveAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [saveAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.getBackResults?([self.searchResults[indexPath.row]])
        self.dismiss(animated: true)
    }
}
