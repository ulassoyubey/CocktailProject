//
//  ErrorManager.swift
//  CocktailProject
//
//  Created by ulas soyubey on 9.03.2022.
//

import Foundation

enum ErrorManager: String, Error {
    case genericError = "error"
    case responseError = "responseError"
    case dataError = "dataError"
    case decodeError = "decodeError"
}
