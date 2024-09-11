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
    
    var userLocation: Location?
    
    let searchPersistence = SearchPersistence()
    let searchService = SearchService()
    var searchResults: [SearchResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.searchField.addTarget(self, action: #selector(UIViewController.dismissKeyboardTouchOutside), for: .editingDidEndOnExit)
        
        self.searchResults = searchPersistence.loadSavedResults()
        
        dismissKeyboard()
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func SearchButtonTapped(_ sender: Any) {
        
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
}

extension SearchViewController: UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = self.searchResults[indexPath.row].title
        cell.detailTextLabel?.text = self.searchResults[indexPath.row].address
        
        return cell

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
