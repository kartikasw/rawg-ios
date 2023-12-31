import SwiftUI
import RxSwift

class HomePresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    
    private let homeUseCase: HomeUseCase
    
    @Published var gamesState: ViewState = .start
    
    enum ViewState {
        case start, loading
        case success(_ games: [GameModel])
        case failure(_ error: String)
    }
    
    func fetchGames() {
        self.gamesState = .loading
        homeUseCase.getGames()
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
        NavigationLink(
            destination: Router.makeDetailView(for: game)) { content() }
    }
    
    init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        fetchGames()
    }
}
