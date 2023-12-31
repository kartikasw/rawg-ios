import Foundation
import RxSwift

class DetailPresenter: ObservableObject {
    private let disposeBag = DisposeBag()
    
    private let detailsGameUseCase: DetailsGameUseCase
    
    @Published var gameState: ViewState = .start
    
    @Published var isFavorite: Bool = false
    
    enum ViewState {
        case start, loading
        case success(_ game: DetailsGameModel)
        case failure(_ error: String)
    }
    
    func getDetailsGame() {
        self.gameState = .loading
        detailsGameUseCase.getDetailsGame()
            .observe(on: MainScheduler.instance)
            .subscribe { result in
                self.gameState = .success(result)
                self.isFavorite = result.isFavorite
            } onError: { error in
                self.gameState = .failure(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    func updateFavorite(with game: DetailsGameModel, isFavorite: Bool) {
        detailsGameUseCase.updateFavorite(with: game, isFavorite: isFavorite)
            .observe(on: MainScheduler.instance)
            .subscribe {
                self.isFavorite = isFavorite
            } onError: { error in
                self.gameState = .failure(error.localizedDescription)
            }.disposed(by: disposeBag)
    }
    
    init(detailsGameUseCase: DetailsGameUseCase) {
        self.detailsGameUseCase = detailsGameUseCase
    }
}
