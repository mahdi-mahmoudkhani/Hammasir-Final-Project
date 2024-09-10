//
//  SearchViewController.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/20/1403 AP.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var SearchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        
        self.dismiss(animated: true)
    }
    
    @IBAction func SearchButtonTapped(_ sender: Any) {
        
        
    }
}

extension SearchViewController: UITabBarDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlaceCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "Title"
        cell.detailTextLabel?.text = "Detail"
        
        return cell

    }

}
