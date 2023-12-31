import SwiftUI

struct GameCard: View {
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
                VStack(
                    alignment: .leading,
                    spacing: Gap.tiny
                ) {
                    Text(game.name)
                        .font(.body)
                        .lineLimit(3, reservesSpace: true)
                    Text(game.released)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
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
