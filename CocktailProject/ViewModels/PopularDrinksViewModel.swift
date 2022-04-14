//
//  PopularDrinksViewModel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 9.04.2022.
//

import Foundation

protocol PopularDrinksViewModelProtocol{
    var drinkKeyword:String { get set}
    var delegate:PopularDrinksViewModelDelegate? {get set }
    
    var drinks:Drinks {get}

    func fetchDrinks(searchedDrink:String)
}

protocol PopularDrinksViewModelDelegate:AnyObject {
    func updateCollectionView()
}

class PopularDrinksViewModel :PopularDrinksViewModelProtocol {
    var drinkKeyword: String
    
    
    init(searchService:SearchService,drinkKeyword:String) {
        self.searchService = searchService
        self.drinkKeyword = drinkKeyword
    }
    
    var drinks: Drinks = Drinks(drinks: [])
    private var searchService:SearchService!
    weak var delegate:PopularDrinksViewModelDelegate?
    
    func fetchDrinks(searchedDrink:String) {
        searchService.searchDrinks(drinkName: searchedDrink) { [weak self] result in
                guard let self = self else {return}
                switch result{
                case .success(let drink):
                    self.drinks = drink
                    self.delegate?.updateCollectionView()
                case .failure(_):
                    ()
                }
        }
}
}

