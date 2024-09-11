//
//  SearchViewController.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/20/1403 AP.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showOnMapButton: UIButton!
    
    var userLocation: Location?
    var areSavedResultsLoaded: Bool?
    var getBackResults: ( (([SearchResult])) -> () )? = nil
    
    let searchPersistence = SearchPersistence()
    let searchService = SearchService()
    var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchField.addTarget(self, action: #selector(UIViewController.dismissKeyboardTouchOutside), for: .editingDidEndOnExit)
        
        self.searchResults = searchPersistence.loadSavedResults()
        self.areSavedResultsLoaded = true
        
        dismissKeyboard()
    }
    
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let numberOfResults = self.searchResults.count
        if numberOfResults == 0 {
            self.showOnMapButton.isEnabled = false
            
        } else {
            self.showOnMapButton.isEnabled = true
        }
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


extension UIViewController {
    
    func dismissKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action:    #selector(UIViewController.dismissKeyboardTouchOutside))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboardTouchOutside() {
        view.endEditing(true)
    }
}
