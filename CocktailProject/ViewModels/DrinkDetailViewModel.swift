//
//  DrinkDetailViewModel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 4.04.2022.
//

import Foundation

protocol DrinkDetailViewModelProtocol {
    var delegate: DrinkDetailDelegate? { get set }
    var drink: SearchDrink { get }
    func loadDrink()
    var isFavorited:Bool { get set}
    func addOrRemoveFromFavorites()
}

protocol DrinkDetailDelegate:AnyObject {
    func setCocktailName(name:String)
    func setHeaderData(drink: SearchDrink)
    func setImage()
    func presentFavoriteError()
    func presentAddFavoritesToast()
    func changeFavoritesButton()
    func presentRemoveFavoritesToast()
}

class DrinkDetailViewModel:DrinkDetailViewModelProtocol {
    var isFavorited: Bool = false
    
    
    var delegate: DrinkDetailDelegate?
    
    func checkisExistInFavorites(){
        PersistanceManager.fetchFavorites { result in
            switch result{
            case .success(let drinks):
                if !drinks.contains(self.drink) {
                    self.isFavorited = false
                    self.delegate?.changeFavoritesButton()
                } else {
                    self.isFavorited = true
                    self.delegate?.changeFavoritesButton()
                }
            case .failure(_):
                self.isFavorited = false
                return
            }
        }
    }
    func addOrRemoveFromFavorites() {
        
        if !isFavorited {
            PersistanceManager.updateWith(drink: drink, actionType: Action.add) { [weak self] error in
                guard let self = self else { return }
                guard let _ = error else {
                    self.isFavorited = true
                    self.delegate?.presentAddFavoritesToast()
                    self.delegate?.changeFavoritesButton()
                    return
                }
                self.delegate?.presentFavoriteError()
            }

        }
        else {
            PersistanceManager.updateWith(drink: drink, actionType: Action.remove) { [weak self ]error in
                guard let self = self else { return }
                guard let _ = error else {
                    self.isFavorited = false
                    self.delegate?.presentRemoveFavoritesToast()
                    self.delegate?.changeFavoritesButton()
                    return
                }
                self.delegate?.presentFavoriteError()
            }
        }
    }
    
    
    init(drink:SearchDrink) {
        self.drink = drink
    }
    
    var ingredientCount: Int? {
        drink.getIngredients().count
    }
    
    var strInstructions: String?
    
    var drink: SearchDrink
    

        
    func loadDrink() {
        strInstructions = drink.strInstructions
        delegate?.setCocktailName(name: drink.strDrink)
        delegate?.setHeaderData(drink: drink)
        delegate?.setImage()
    }
    
}
