//
//  FavoriteButton.swift
//  RawgApp
//
//  Created by Kartika Sari on 27/12/23.
//

import SwiftUI

struct FavoriteButton: View {
    @ObservedObject var detailPresenter: DetailPresenter
    var game: DetailsGameModel
    @Binding var isSet: Bool
    @Binding var refreshPrevious: Bool
    
    var body: some View {
        Button {
            detailPresenter.updateFavorite(with: game, isFavorite: !isSet)
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "heart.fill" : "heart")
                .labelStyle(IconOnlyLabelStyle())
                .foregroundColor(isSet ? .red : .gray)
                .font(.system(size: 24))
        }
    }
}
