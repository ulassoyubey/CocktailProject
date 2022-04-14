//
//  FavoritesViewModel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 15.04.2022.
//

import Foundation

protocol FavoritesDelegate:AnyObject {
    func startSpinner()
    func setCells()
    func endSpinner()
}

class FavoritesViewModel {
    
    weak var delegate:FavoritesDelegate?
    var favoritedDrinks:[SearchDrink] = []
    
     func fetchDrinks(){
        self.delegate?.startSpinner()
        PersistanceManager.fetchFavorites { result in
            switch result{
            case .success(let drinks):
                self.favoritedDrinks = drinks
                self.delegate?.setCells()
                self.delegate?.endSpinner()
            case .failure(_):
                print("failure")
                self.delegate?.endSpinner()
            }
        }
    }
}
