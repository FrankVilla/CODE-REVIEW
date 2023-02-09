//
//  Errorhandling.swift
//  Riskmethods
//
//  Created by Erinson Villarroel on 26/02/2022.
//

import Foundation
enum MovError: String,Error {
    
    case invalidRequest   = "Invalid request. Please check URL"
    case invalidResponse  = "Check your internet connection"
    case unableToComplete = "Request can't be completed"
    case invalidData      = "Invalid Data"
    case unableToParse    = "JSON can not be parsed"
    case unableToFavorite = "This user can not be added to favorites"
    case alreadyExists    = "Unable to favorite. You already favorited this movie!"
}
