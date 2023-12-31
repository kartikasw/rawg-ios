//
//  FavoriteViewModel.swift
//  RawgApp
//
//  Created by Kartika Sari on 26/12/23.
//

import Foundation
import RxSwift
import SwiftUI

class FavoritePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    
    private let favoriteUseCase: FavoriteUseCase
    
    @Published var gamesState: ViewState = .start
    
    enum ViewState {
        case start, loading
        case success(_ games: [GameModel])
        case failure(_ error: String)
    }
    
    func getFavorites() {
        self.gamesState = .loading
        favoriteUseCase.getFavoriteGames()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gamesState = .success(result)
            } onError: { error in
                self.gamesState = .failure(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func linkBuilder<Content: View>(
        for game: GameModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(destination: Router.makeDetailView(for: game)) { content() }
    }
    
    init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
    }
}
