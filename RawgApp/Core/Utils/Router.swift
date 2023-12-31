//
//  Router.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import SwiftUI

class Router {
    
    static func makeDetailView(for game: GameModel) -> some View {
        let detailUseCase = Injection.instance.provideDetail(game: game)
        let presenter = DetailPresenter(detailsGameUseCase: detailUseCase)
        return GameDetail(detailPresenter: presenter, refreshPrevious: .constant(false))
    }
    
}
