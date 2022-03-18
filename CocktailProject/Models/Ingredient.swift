//
//  Ingredient.swift
//  CocktailProject
//
//  Created by ulas soyubey on 17.03.2022.
//

import Foundation

struct Ingredients: Codable {
    let ingredients: [Ingredient]
}

struct Ingredient : Codable {
    let idIngredient : String?
    let strIngredient : String?
    let strDescription : String?
    let strType : String?
    let strAlcohol : String?
    let strABV : String?
}
