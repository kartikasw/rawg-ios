//
//  DetailsGameInteractor.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation
import RxSwift

protocol DetailsGameUseCase {
    
    func getDetailsGame() -> Observable<DetailsGameModel>
    
    func updateFavorite(with game: DetailsGameModel, isFavorite: Bool) -> Observable<Void>
    
}

class DetailsGameInteractor: DetailsGameUseCase {
    
    private let repository: RawgRepositoryProtocol
    private let game: GameModel
    
    required init(repository: RawgRepositoryProtocol, game: GameModel) {
        self.repository = repository
        self.game = game
    }
    
    func getDetailsGame() -> Observable<DetailsGameModel> {
        return repository.getDetailsGame(id: game.id)
    }
    
    func updateFavorite(with game: DetailsGameModel, isFavorite: Bool) -> Observable<Void> {
        return repository.updateFavorite(with: game, isFavorite: isFavorite)
    }
    
}
