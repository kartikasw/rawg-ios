//
//  CustomError.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation

enum APIError: LocalizedError {
    
    case invalidURL
    case invalidResponse
    case addressUnreachable(URL)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
    
}

enum DatabaseError: LocalizedError {
    
    case invalidInstance
    case requestFailed
    case notFound
    
    var errorDescription: String? {
        switch self {
        case .invalidInstance: return "Database can't instance."
        case .requestFailed: return "Your request failed."
        case .notFound: return "No data found."
        }
    }
    
}
