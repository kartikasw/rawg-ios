//
//  FavoriteInteractor.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    
    func getFavoriteGames() -> Observable<[GameModel]>
    
}

class FavoriteInteractor: FavoriteUseCase {
    
    private let repository: RawgRepositoryProtocol
    
    required init(repository: RawgRepositoryProtocol) {
        self.repository = repository
    }
    
    func getFavoriteGames() -> Observable<[GameModel]> {
        return repository.getGames(isFavorite: true)
    }
    
}
