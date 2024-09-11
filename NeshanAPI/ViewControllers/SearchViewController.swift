//
//  SearchViewController.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/20/1403 AP.
//

import UIKit
import CoreLocation

class SearchViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showOnMapButton: UIButton!
    
    // MARK: - Stored Properties
    
    var userLocation: Location?
    var areSavedResultsLoaded: Bool?
    var getBackResults: ( (([SearchResult])) -> () )? = nil
    
    let searchPersistence = SearchPersistence()
    let searchService = SearchService()
    var searchResults: [SearchResult] = []
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.searchField.addTarget(self, action: #selector(UIViewController.dismissKeyboardTouchOutside), for: .editingDidEndOnExit)
        
        self.searchResults = self.searchPersistence.loadSavedResults()
        self.areSavedResultsLoaded = true
        
        self.dismissKeyboard()
    }
    
}
