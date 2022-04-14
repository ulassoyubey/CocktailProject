//
//  PersistanceManager.swift
//  CocktailProject
//
//  Created by ulas soyubey on 14.04.2022.
//

import Foundation

enum Action {
    case add,remove
}

struct PersistanceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorite = "favorites"
    }
    
    static func updateWith(drink:SearchDrink,actionType:Action,completionHandler: @escaping (ErrorManager?) -> Void) {
        fetchFavorites { result in
            switch result {
            case .success(let drinks):
                var retrievedFavorites = drinks
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(drink) else {
                        completionHandler(.duplicateData)
                        return
                    }
                    retrievedFavorites.append(drink)
                case .remove:
                    retrievedFavorites.removeAll(where: { $0.idDrink == drink.idDrink })
                }
                
                completionHandler(save(favorites: retrievedFavorites))
            case .failure(let error):
                completionHandler(error)
            }
        }
    }
    
    static func fetchFavorites(completionHandler: @escaping (Result<[SearchDrink],ErrorManager>) -> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorite) as? Data else {
            completionHandler(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
                let favorites = try decoder.decode([SearchDrink].self, from: favoritesData)
            completionHandler(.success(favorites))
        }catch {
            completionHandler(.failure(.decodeError))
        }
    }
    
    static func save(favorites:[SearchDrink]) -> ErrorManager? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorite = try encoder.encode(favorites)
            defaults.set(encodedFavorite, forKey: Keys.favorite)
            return nil
        }catch {
            return .decodeError
        }
    }
    
}
