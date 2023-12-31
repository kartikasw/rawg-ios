//
//  LocaleDataSource.swift
//  RawgApp
//
//  Created by Kartika Sari on 30/12/23.
//

import Foundation
import RealmSwift
import RxSwift

protocol LocaleDataSourceProtocol: AnyObject {
    
    func getFavoriteGames() -> Observable<[GameEntity]>
    
    func getFavoriteGame(by id: String) -> Observable<GameEntity?>
    
    func updateFavoriteGame(with game: GameEntity, isFavorite: Bool) -> Observable<Void>
    
}

final class LocaleDataSource: NSObject {
    
    private let realm: Realm?
    
    private static var shared: LocaleDataSource?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static func createInstance() -> LocaleDataSource {
        if let existingInstance = shared {
            return existingInstance
        } else {
            var realm: Realm?
            
            do {
                realm = try Realm()
            } catch let error {
                print("Realm initialization error: \(error)")
            }
            
            let newInstance = LocaleDataSource(realm: realm)
            shared = newInstance
            return newInstance
        }
    }
    
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    
    func getFavoriteGames() -> Observable<[GameEntity]> {
        return Observable<[GameEntity]>.create { observer in
            if let realm = self.realm {
                let favorites: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                observer.onNext(favorites.toArray(ofType: GameEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getFavoriteGame(by id: String)  -> Observable<GameEntity?> {
        return Observable<GameEntity?>.create { observer in
            guard let realm = self.realm else {
                print("Locale Data Source: getFavoriteGameById, error")
                observer.onError(DatabaseError.invalidInstance)
                return Disposables.create()
            }
            
            if let game = realm.object(ofType: GameEntity.self, forPrimaryKey: id) {
                observer.onNext(game)
            } else {
                observer.onNext(nil)
            }
            
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func updateFavoriteGame(with game: GameEntity, isFavorite: Bool) -> Observable<Void> {
        print("Locale Data Source: updateFavoriteGame with favorite \(isFavorite)")
        return Observable<Void>.create { observer in
            guard let realm = self.realm else {
                print("Locale Data Source: updateFavoriteGame, error")
                observer.onError(DatabaseError.invalidInstance)
                return Disposables.create()
            }
            
            do {
                try realm.write {
                    if let existingGame = realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) {
                        if isFavorite {
                            // Game exists, update it
                            existingGame.isFavorite = true
                        } else {
                            // Game exists and isFavorite is false, delete it
                            realm.delete(existingGame)
                        }
                    } else if isFavorite {
                        // Game doesn't exist, but isFavorite is true, so create a new game
                        realm.add(game)
                    } else {
                        // Game doesn't exist and isFavorite is false, do nothing
                    }
                    
                    observer.onNext(())
                    observer.onCompleted()
                }
            } catch {
                observer.onError(DatabaseError.requestFailed)
            }
            
            return Disposables.create()
        }
    }
}

extension Results {
    
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
    
}
