//
//  IngredientDetailViewModel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 5.04.2022.
//

import Foundation

protocol IngredientViewModelProtocol {
    
    var delegate:IngredientViewModelDelegate? { get set}
    var ingredientName:String? {get set}
    
    func fetchIngredientDetail(ingName:String)
    var ingredientSource:Ingredient? { get}
}

protocol IngredientViewModelDelegate:AnyObject {
    func setIngredientDetail(ingredient:Ingredients)
    func choosenIngredient(ingredientName:String)
}

class IngredientDetailViewModel:IngredientViewModelProtocol {
    
    init(ingredientName:String) {
        self.ingredientName = ingredientName
    }
    
    var ingredientName: String?
    
    var ingredientSource:Ingredient?
    
    weak var delegate:IngredientViewModelDelegate?
    
    func fetchIngredientDetail(ingName: String) {
        NetworkManager.shared.searchIngredient(ingredientName: ingName) { result in
            switch result {
            case .success(let ingredient):
                self.ingredientSource = ingredient.ingredients.first
                self.delegate?.setIngredientDetail(ingredient: ingredient)
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    
}
