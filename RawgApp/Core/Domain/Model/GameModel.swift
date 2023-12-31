//
//  GameModel.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation

struct GameModel: Equatable, Identifiable {
    
    let id: Int
    let name: String
    let released: String
    let backgroundImage: String
    let rating: Double
    let ratingsCount: Int
    
}
