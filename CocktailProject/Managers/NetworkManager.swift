//
//  NetworkManager.swift
//  CocktailProject
//
//  Created by ulas soyubey on 9.03.2022.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://www.thecocktaildb.com/api/json/v1/1/"
    let cache = NSCache<NSString,UIImage>()
    private init(){}
    
    func searchDrinks(drinkName: String,completionHandler:@escaping (Result<Drinks,ErrorManager>) -> Void){
        let endpoint = baseUrl + "search.php?s=\(drinkName)"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.genericError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            if let _ = error {
                completionHandler(.failure(.genericError))
            }
            
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completionHandler(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Drinks.self, from: data)
                completionHandler(.success(result))
            }catch {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }
    
    func downloadImage(from urlString:String,completionHandler:@escaping (UIImage?) -> Void){
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            print("cache found \(cacheKey)")
            completionHandler(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completionHandler(nil)
                      return
                  }
            self.cache.setObject(image, forKey: cacheKey)
            print(cacheKey)
            completionHandler(image)
        }
        task.resume()
    }
    
    func searchIngredient(ingredientName: String,completionHandler:@escaping (Result<Ingredients,ErrorManager>) -> Void){
        let endpoint = baseUrl + "search.php?i=\(ingredientName)"
        
        guard let url = URL(string: endpoint) else {
            completionHandler(.failure(.genericError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            
            if let _ = error {
                completionHandler(.failure(.genericError))
            }
            
            
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                completionHandler(.failure(.responseError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.dataError))
                return
            }

            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(Ingredients.self, from: data)
                print(result)
                completionHandler(.success(result))
            }catch {
                completionHandler(.failure(.decodeError))
            }
        }
        task.resume()
    }
}
