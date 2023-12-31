import SwiftUI

struct GameDetail: View {
    @ObservedObject var detailPresenter: DetailPresenter
    @Binding var refreshPrevious: Bool
    
    init(detailPresenter: DetailPresenter, refreshPrevious: Binding<Bool>) {
        self.detailPresenter = detailPresenter
        self._refreshPrevious = refreshPrevious
    }
    
    var body: some View {
        switch detailPresenter.gameState {
        case .start:
            ProgressView()
                .navigationTitle("Game Detail")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    self.detailPresenter.getDetailsGame()
                }
        case .loading:
            ProgressView()
                .navigationTitle("Game Detail")
                .navigationBarTitleDisplayMode(.inline)
        case let .success(game):
            ScrollView(showsIndicators: false) {
                VStack(
                    spacing: Gap.none
                ) {
                    gameDetailImage(game.backgroundImage)
                    VStack(
                        alignment: .leading,
                        spacing: Gap.medium
                    ) {
                        GameRateItem(
                            label: "\(Formatter.formatNumber(game.ratingsCount)) RATINGS",
                            title: game.rating.description,
                            text: { RatingView(rating: game.rating) }
                        )
                        Divider()
                        
                        HStack(
                            alignment: .top
                        ) {
                            Text(game.name)
                                .font(.title2)
                                .fontWeight(.bold)
                                .lineLimit(3)
                            Spacer()
                            FavoriteButton(
                                detailPresenter: detailPresenter,
                                game: game,
                                isSet: $detailPresenter.isFavorite,
                                refreshPrevious: $refreshPrevious
                            )
                        }
                        Text(game.description)
                        Divider()
                        VStack(
                            alignment: .leading,
                            spacing: Gap.small
                        ) {
                            Text("Information")
                                .font(.title2)
                                .fontWeight(.bold)
                            GameInfoItem(
                                label: "Release Date",
                                text: game.released
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Game Detail")
            .navigationBarTitleDisplayMode(.inline)
        case let .failure(error):
            Text(error)
                .navigationTitle("Game Detail")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
