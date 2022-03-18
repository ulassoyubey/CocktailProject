//
//  Drinks.swift
//  CocktailProject
//
//  Created by ulas soyubey on 9.03.2022.
//

import Foundation

struct Drinks: Codable {
    let drinks: [SearchDrink]
}

struct SearchDrink: Codable,Hashable{
    let idDrink:String
    let strDrink:String
    let strCategory:String
    let strAlcoholic:String
    let strDrinkThumb:String
    let strGlass:String
    let strInstructions:String
    var strIngredient1:String?
    var strIngredient2:String?
    var strIngredient3:String?
    var strIngredient4:String?
    var strIngredient5:String?
    var strIngredient6:String?
    var strIngredient7:String?
    var strIngredient8:String?
    var strIngredient9:String?
    var strIngredient10:String?
    var strIngredient11:String?
    var strIngredient12:String?
    var strIngredient13:String?
    var strIngredient14:String?
    var strIngredient15:String?
    var strMeasure1:String?
    var strMeasure2:String?
    var strMeasure3:String?
    var strMeasure4:String?
    var strMeasure5:String?
    var strMeasure6:String?
    var strMeasure7:String?
    var strMeasure8:String?
    var strMeasure9:String?
    var strMeasure10:String?
    var strMeasure11:String?
    var strMeasure12:String?
    var strMeasure13:String?
    var strMeasure14:String?
    var strMeasure15:String?
    
    func hash(into hasher: inout Hasher) {
         hasher.combine(idDrink)
     }
    
    static func == (lhs: SearchDrink, rhs: SearchDrink) -> Bool {
        lhs.idDrink == rhs.idDrink
    }

    func getIngredients() ->[String] {
        var ingredients = [String]()
        ingredients.append(strIngredient1 ?? "")
        ingredients.append(strIngredient2 ?? "")
        ingredients.append(strIngredient3 ?? "")
        ingredients.append(strIngredient4 ?? "")
        ingredients.append(strIngredient5 ?? "")
        ingredients.append(strIngredient6 ?? "")
        ingredients.append(strIngredient7 ?? "")
        ingredients.append(strIngredient8 ?? "")
        ingredients.append(strIngredient9 ?? "")
        ingredients.append(strIngredient10 ?? "")
        ingredients.append(strIngredient11 ?? "")
        ingredients.append(strIngredient12 ?? "")
        ingredients.append(strIngredient13 ?? "")
        ingredients.append(strIngredient14 ?? "")
        ingredients.append(strIngredient15 ?? "")
        
        return ingredients.filter {!$0.isEmpty}
    }
    
    func getMeasures() -> [String] {
        var measures = [String]()
        measures.append(strMeasure1 ?? "")
        measures.append(strMeasure2 ?? "")
        measures.append(strMeasure3 ?? "")
        measures.append(strMeasure4 ?? "")
        measures.append(strMeasure5 ?? "")
        measures.append(strMeasure6 ?? "")
        measures.append(strMeasure7 ?? "")
        measures.append(strMeasure8 ?? "")
        measures.append(strMeasure9 ?? "")
        measures.append(strMeasure10 ?? "")
        measures.append(strMeasure11 ?? "")
        measures.append(strMeasure12 ?? "")
        measures.append(strMeasure13 ?? "")
        measures.append(strMeasure14 ?? "")
        measures.append(strMeasure15 ?? "")
        
        return measures
    }
    
    func getMeasuresWithIngredients() -> [String:String] {
        var dict = [String:String]()
        
        for (index,ingredient) in getIngredients().enumerated() {
            dict[ingredient] = getMeasures()[index]
        }
        return dict
    }

}

