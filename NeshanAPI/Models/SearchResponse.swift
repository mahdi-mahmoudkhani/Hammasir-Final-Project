//
//  SearchResponse.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/20/1403 AP.
//

import Foundation

struct SearchResponse: Codable {
    
    let count: Int
    let items: [SearchResult]
}
