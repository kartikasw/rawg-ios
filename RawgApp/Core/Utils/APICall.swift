//
//  Endpoints.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation

struct API {
    
    static let baseUrl = "https://api.rawg.io/api/"
    
    static let apiKey: String = {
        guard let filePath = Bundle.main.path(forResource: "Rawg-Info", ofType: "plist") else {
            fatalError("Couldn't find file 'Rawg-Info.plist'.")
        }
        
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'Rawg-Info.plist'.")
        }
        return value
    }()
    
}

protocol Endpoint {

    var url: String { get }
    
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case games
        case detailsGame
        
        public var url: String {
            switch self {
            case .games: return "\(API.baseUrl)games?key=\(API.apiKey)"
            case .detailsGame: return "\(API.baseUrl)games/{id}?key=\(API.apiKey)"
            }
        }
    }
    
}
