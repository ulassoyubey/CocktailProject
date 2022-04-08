//
//  SearchViewModel.swift
//  CocktailProject
//
//  Created by ulas soyubey on 2.04.2022.
//

import Foundation

protocol SearchService {
    func searchDrinks(drinkName: String,completionHandler:@escaping (Result<Drinks,ErrorManager>) -> Void)
}

protocol SearchViewModelDelegate:AnyObject {
    func updateSearchResult()
    func showNoDrink()
}

class SearchViewModel{
    
    private(set) var drinkDataSource = Drinks(drinks: [])
    
    private var searchService:SearchService!
    weak var delegate:SearchViewModelDelegate!
    
    init(searchService:SearchService){
        self.searchService = searchService
    }
    func fetchDrinks(searchedDrink:String){
        searchService.searchDrinks(drinkName: searchedDrink) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let drink):
                self.drinkDataSource = drink
                self.delegate?.updateSearchResult()
            case .failure(_):
                self.delegate?.showNoDrink()
            }
        }
    }
}
