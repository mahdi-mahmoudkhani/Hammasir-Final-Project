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
    
    func loadSavedResults() -> [SearchResult] {
        
        guard let savedResults = UserDefaults.standard.object(forKey: savedResultsKey) as? Data else {
            
            return []
        }
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode([SearchResult].self, from: savedResults)
            return data
            
        } catch {
            
            return []
        }
    }
    
}
