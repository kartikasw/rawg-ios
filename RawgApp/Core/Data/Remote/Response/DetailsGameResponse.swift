//
//  DetailsGameResponse.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation

struct DetailsGameResponse: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id, slug, name, description, released, tba, website, rating, added, metacritic, playtime, updated
        case nameOriginal = "name_original"
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case ratingTop = "rating_top"
        case ratingsCount = "ratings_count" 
        case suggestionsCount = "suggestions_count"
    }
    
    let id: Int
    let slug: String
    let name: String
    let nameOriginal: String
    let description: String
    let released: String
    let tba: Bool
    let backgroundImage: String
    let backgroundImageAdditional: String
    let website: String
    let rating: Double
    let ratingTop: Int
    let ratingsCount: Int
    let added: Int
    let metacritic: Int
    let playtime: Int
    let suggestionsCount: Int
    let updated: String
}
