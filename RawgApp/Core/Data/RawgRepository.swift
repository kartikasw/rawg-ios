//
//  RawgRepository.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation
import RxSwift

protocol RawgRepositoryProtocol {
    
    func getGames( isFavorite: Bool) -> Observable<[GameModel]>
    
    func getDetailsGame(id: Int) -> Observable<DetailsGameModel>
    
    func updateFavorite(with game: DetailsGameModel, isFavorite: Bool) -> Observable<Void>
    
}

final class RawgRepository: NSObject {
    
    typealias RawgInstance = (LocaleDataSource, RemoteDataSource) -> RawgRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    // Singleton instance
    private static var shared: RawgRepository?
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static func createInstance(_ locale: LocaleDataSource, _ remote: RemoteDataSource) -> RawgRepository {
        if let existingInstance = shared {
            return existingInstance
        } else {
            let newInstance = RawgRepository(locale: locale, remote: remote)
            shared = newInstance
            return newInstance
        }
    }
}

extension RawgRepository: RawgRepositoryProtocol {
    
    func getGames( isFavorite: Bool) -> Observable<[GameModel]> {
        if isFavorite {
            return self.locale.getFavoriteGames().map { GameMapper.mapGameEntitiesToDomains(input: $0) }
        } else {
            return self.remote.getGames().map { GameMapper.mapGameResponsesToDomains(input: $0) }
        }
    }
    
    func getDetailsGame(id: Int) -> Observable<DetailsGameModel> {
        print("RawgRepository: getDetailsGame")
        return self.locale.getFavoriteGame(by: String(id))
            .flatMap { [weak self] gameEntity -> Observable<DetailsGameModel> in
                guard let self = self else {
                    return Observable.error(DatabaseError.requestFailed)
                }
                
                if let gameEntity = gameEntity {
                    // Details found locally, map to DetailsGameModel
                    let detailsGameModel = GameMapper.mapGameEntityToDomain(input: gameEntity)
                    return Observable.just(detailsGameModel)
                } else {
                    // Details not found locally, fetch from remote
                    return self.remote.getDetailsGame(for: id)
                        .map { GameMapper.mapDetailsGameResponseToDomain(input: $0) }
                }
            }
    }
    
    func updateFavorite(
        with game: DetailsGameModel,
        isFavorite: Bool
    ) -> Observable<Void> {
        print("RawgRepository: updateFavorite")
        let gameEntity = GameMapper.mapDetailsGameModelToEntity(input: game, isFavorite: isFavorite)
        return self.locale.updateFavoriteGame(with: gameEntity, isFavorite: isFavorite)
    }
}
