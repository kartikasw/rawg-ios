//
//  Injection.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation
import RealmSwift

final class Injection: NSObject {
    
    static let instance: Injection = Injection()
    
    private func provideRepository() -> RawgRepositoryProtocol {
        let locale: LocaleDataSource = LocaleDataSource.createInstance()
        let remote: RemoteDataSource = RemoteDataSource.instance
        
        return RawgRepository.createInstance(locale, remote)
    }
    
    func provideHome() -> HomeUseCase {
        let repository = provideRepository()
        return HomeInteractor(repository: repository)
    }
    
    func provideDetail(game: GameModel) -> DetailsGameUseCase {
        let repository = provideRepository()
        return DetailsGameInteractor(repository: repository, game: game)
    }
    
    func provideFavorite() -> FavoriteUseCase {
        let repository = provideRepository()
        return FavoriteInteractor(repository: repository)
    }
    
}
