//
//  HomeInteractor.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    
    func getGames() -> Observable<[GameModel]>
    
}

class HomeInteractor: HomeUseCase {
    
    private let repository: RawgRepositoryProtocol
    
    required init(repository: RawgRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGames() -> Observable<[GameModel]> {
        return repository.getGames(isFavorite: false)
    }
    
}
