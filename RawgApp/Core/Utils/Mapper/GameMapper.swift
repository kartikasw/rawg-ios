//
//  GameMapper.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation

final class GameMapper {
    
    static func mapGameResponsesToDomains(
        input gameResponses: [GameResponse]
    ) -> [GameModel] {
        
        return gameResponses.map { result in
            return GameModel(
                id: result.id,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                ratingsCount: result.ratingsCount
            )
        }
    }
    
    static func mapGameEntitiesToDomains(
        input gameEntities: [GameEntity]
    ) -> [GameModel] {
        return gameEntities.map { result in
            return GameModel(
                id: Int(result.id) ?? 0,
                name: result.name,
                released: result.released,
                backgroundImage: result.backgroundImage,
                rating: result.rating,
                ratingsCount: result.ratingsCount
            )
        }
    }
    
    static func mapDetailsGameResponseToDomain(
        input result: DetailsGameResponse
    ) -> DetailsGameModel {
        
        return DetailsGameModel(
            id: result.id,
            name: result.name,
            description: result.description,
            released: result.released,
            backgroundImage: result.backgroundImage,
            rating: result.rating,
            ratingsCount: result.ratingsCount,
            isFavorite: false
        )
    }
    
    static func mapGameEntityToDomain(
        input result: GameEntity
    ) -> DetailsGameModel {
        
        return DetailsGameModel(
            id: Int(result.id) ?? 0,
            name: result.name,
            description: result.desc,
            released: result.released,
            backgroundImage: result.backgroundImage,
            rating: result.rating,
            ratingsCount: result.ratingsCount,
            isFavorite: result.isFavorite
        )
        
    }
    
    static func mapDetailsGameModelToEntity(input: DetailsGameModel, isFavorite: Bool) -> GameEntity {
        let gameEntity = GameEntity()
        gameEntity.id = String(input.id)
        gameEntity.name = input.name
        gameEntity.desc = input.description
        gameEntity.released = input.released
        gameEntity.backgroundImage = input.backgroundImage
        gameEntity.rating = input.rating
        gameEntity.ratingsCount = input.ratingsCount
        gameEntity.isFavorite = isFavorite
        return gameEntity
    }
    
}
