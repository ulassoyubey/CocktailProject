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
}

protocol DrinkDetailDelegate:AnyObject {
    func setCocktailName(name:String)
    func setHeaderData(drink: SearchDrink)
    func setImage()
}

class DrinkDetailViewModel:DrinkDetailViewModelProtocol {
    
    init(drink:SearchDrink) {
        self.drink = drink
    }
    
    var ingredientCount: Int?
    
    var strInstructions: String?
    
    var drink: SearchDrink
    
    var delegate: DrinkDetailDelegate?

        
    func loadDrink() {
        ingredientCount = drink.getIngredients().count
        strInstructions = drink.strInstructions
        delegate?.setCocktailName(name: drink.strDrink)
        delegate?.setHeaderData(drink: drink)
        delegate?.setImage()
    }
    
}
