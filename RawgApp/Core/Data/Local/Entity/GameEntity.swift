//
//  GameEntity.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation
import RealmSwift

class GameEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var released: String = ""
    @objc dynamic var backgroundImage: String = ""
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var ratingsCount: Int = 0
    @objc dynamic var isFavorite: Bool = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
