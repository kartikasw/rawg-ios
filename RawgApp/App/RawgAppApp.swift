//
//  RawgAppApp.swift
//  RawgApp
//
//  Created by Kartika Sari on 19/12/23.
//

import SwiftUI

@main
struct RawgAppApp: App {
    let homePresenter = HomePresenter(homeUseCase: Injection.instance.provideHome())
    let favoritePresenter = FavoritePresenter(favoriteUseCase: Injection.instance.provideFavorite())
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(homePresenter)
                .environmentObject(favoritePresenter)
        }
    }
}
