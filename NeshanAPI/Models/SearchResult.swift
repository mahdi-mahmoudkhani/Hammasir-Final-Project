//
//  SearchResult.swift
//  NeshanAPI
//
//  Created by Mahdi on 6/20/1403 AP.
//

import Foundation

struct SearchResult: Codable {
    
    let title: String
    let address: String
    let location: Location
}
