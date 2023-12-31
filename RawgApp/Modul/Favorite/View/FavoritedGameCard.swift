//
//  FavoritedGamecard.swift
//  RawgApp
//
//  Created by Kartika Sari on 27/12/23.
//

import SwiftUI

struct FavoritedGameCard: View {
    @State var game: GameModel
    
    var body: some View {
        VStack(
            alignment: .leading
        ) {
            gameItemImage(game.backgroundImage)
            VStack(
                alignment: .leading,
                spacing: Gap.small
            ) {
                HStack(
                    alignment: .top,
                    spacing: Gap.tiny
                ) {
                    Text(game.name)
                        .font(.body)
                        .lineLimit(3, reservesSpace: true)
                    Spacer()
                    Image(systemName: "heart.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.red)
                }
                
                Text(game.released)
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                HStack(
                    spacing: Gap.tiny
                ) {
                    Image(systemName: "star.fill")
                        .font(.system(size: 12))
                        .foregroundColor(.yellow)
                    Text(game.rating.description)
                        .font(.footnote)
                }
            }
            .padding([.leading, .trailing, .bottom], Gap.small)
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(Shape.roundedCorner)
    }
}
