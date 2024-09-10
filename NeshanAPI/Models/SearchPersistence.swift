//
//  SearchPersistence.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/21/1403 AP.
//

import Foundation

class SearchPersistence {
    
    private let savedResultsKey = "savedSearchResults"
    
    func saveSearchResults(_ results: [SearchResult]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(results)
            UserDefaults.standard.set(data, forKey: savedResultsKey)
        } catch {
            print("Failed to save search results: \(error)")
        }
    }
    
}
