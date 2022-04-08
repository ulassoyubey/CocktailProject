//
//  TopHeaderCollectionViewModel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 8.04.2022.
//

import Foundation

protocol TopHeaderViewModelProtocol{
    var delegate:TopHeaderDelegate? {get set }
    
    var drinks:Drinks {get}

    func fetchDrinks(searchedDrink:String)
}

protocol TopHeaderDelegate:AnyObject {
    func updateCollectionView()
}

class TopHeaderViewModel :TopHeaderViewModelProtocol {
    
    init(searchService:SearchService) {
        self.searchService = searchService
    }
    
    var drinks: Drinks = Drinks(drinks: [])
    private var searchService:SearchService!
    weak var delegate:TopHeaderDelegate?
    
    func fetchDrinks(searchedDrink:String) {
        NetworkManager.shared.searchDrinks(drinkName: searchedDrink) { [weak self] result in
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
