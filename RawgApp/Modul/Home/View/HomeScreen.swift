import SwiftUI

struct HomeScreen: View {
    @ObservedObject var homePresenter: HomePresenter
    
    var body: some View {
        NavigationView {
            ZStack {
                switch homePresenter.gamesState {
                case .start, .loading:
                    ProgressView()
                        .frame(height: 170)
                case let .success(games):
                    ScrollView(showsIndicators: false) {
                        LazyVStack {
                            ForEach(games) { game in
                                self.homePresenter.linkBuilder(for: game) {
                                    GameCard(game: game)
                                }
                                .buttonStyle(.plain)
                                .padding(.bottom, Gap.medium)
                            }
                        }
                        .padding(.horizontal, Gap.medium)
                    }
                case let .failure(error):
                    Text(error)
                        .onAppear {
                            print(error)
                        }
                        .padding()
                }
            }
            .navigationTitle("Home")
        }
    }
}
