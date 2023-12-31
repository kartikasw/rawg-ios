//
//  GameResponse.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation

struct GamesResponse: Decodable {
    let results: [GameResponse]
}

struct GameResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, slug, name, released, tba, rating, added, metacritic, playtime, updated
        case backgroundImage = "background_image"
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
    }
    
    let id: Int
    let slug: String
    let name: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let rating: Double
    let ratingTop: Int
    let ratingsCount: Int
    let added: Int
    let metacritic: Int
    let playtime: Int
    let suggestionsCount: Int
    let updated: String
}
