//
//  SearchService.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/20/1403 AP.
//

import Foundation

class SearchService {
    
    func search(for term: String, around userLocation: Location) async throws -> SearchResponse {
        
        let endPoint = "\(APIConfig.baseURL)term=\(term)&lat=\(userLocation.y)&long=\(userLocation.x)"
        
        guard let url = URL(string: endPoint) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.addValue(APIConfig.apiKey, forHTTPHeaderField: "Api-Key")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            return try JSONDecoder().decode(SearchResponse.self, from: data)
            
        } catch {
            
            throw URLError(.cannotDecodeRawData)
        }

    }
}
