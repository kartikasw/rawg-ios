//
//  RemoteDataSource.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Alamofire
import Foundation
import RxSwift

protocol RemoteDataSourceProtocol: AnyObject {
    
    func getGames() -> Observable<[GameResponse]>
    
    func getDetailsGame(for gameId: Int) -> Observable<DetailsGameResponse>
    
}


final class RemoteDataSource: NSObject {
    
    static let instance: RemoteDataSource =  RemoteDataSource()
    
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getGames() -> Observable<[GameResponse]> {
        return Observable<[GameResponse]>.create { observer in
            if let url = URL(string: Endpoints.Gets.games.url) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: GamesResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value.results)
                            observer.onCompleted()
                        case .failure(let error):
                            print("Remote Data Source: getGames error - \(error)")
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("Response data: \(utf8Text)")
                            }
                            observer.onError(error)
                        }
                    }
            } else {
                let error = APIError.invalidURL
                print("Remote Data Source: getGames error - \(error)")
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func getDetailsGame(for gameId: Int) -> Observable<DetailsGameResponse> {
        return Observable<DetailsGameResponse>.create { observer in
            if let url = URL(
                string: Endpoints.Gets.detailsGame.url.replacingOccurrences(
                    of: "{id}",
                    with: String(gameId),
                    options: .literal,
                    range: nil
                )
            ) {
                AF.request(url)
                    .validate()
                    .responseDecodable(of: DetailsGameResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure(let error):
                            print("Remote Data Source: getDetailsGame error - \(error)")
                            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                                print("Response data: \(utf8Text)")
                            }
                            observer.onError(APIError.invalidResponse)
                        }
                    }
            } else {
                let error = APIError.invalidURL
                print("Remote Data Source: getDetailsGame error - \(error)")
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
}
