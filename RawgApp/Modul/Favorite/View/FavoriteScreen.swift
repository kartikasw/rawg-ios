//
//  FavoriteScreen.swift
//  RawgApp
//
//  Created by Kartika Sari on 26/12/23.
//

import SwiftUI

struct FavoriteScreen: View {
    @ObservedObject var favoritePresenter: FavoritePresenter
    
    var body: some View {
        NavigationStack {
            switch favoritePresenter.gamesState {
            case .start, .loading:
                ProgressView()
                    .navigationTitle("Favorite")
            case let .success(games):
                if games.isEmpty {
                    Text("No favorite")
                        .foregroundColor(.secondary)
                        .padding()
                        .navigationTitle("Favorite")
                } else {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: Array(repeating: .init(.flexible()), count: 2)) {
                            ForEach(games) { game in
                                ForEach(games) { game in
                                    self.favoritePresenter.linkBuilder(for: game) {
                                        FavoritedGameCard(game: game)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .padding()
                        .navigationTitle("Favorite")
                    }
                }
            case let .failure(error):
                Text(error)
                    .onAppear {
                        print(error)
                    }
                    .padding()
                    .navigationTitle("Favorite")
            }
        }
        .onAppear {
            favoritePresenter.getFavorites()
        }
    }
}
