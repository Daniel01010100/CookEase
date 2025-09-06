//
//  Diet.swift
//  CookEase
//
//  Created by YUDONG LU on 25/8/2025.
//

import Foundation

enum Diet: String, Codable, CaseIterable {
    case standard
    case glutenFree = "gluten free"
    case ketogenic = "ketogenic"
    case vegetarian = "vegetarian"
    case lactoVegetarian = "lacto-vegetarian"
    case ovoVegetarian = "ovo-vegetarian"
    case vegan = "vegan"
    case pescetarian = "pescetarian"
    case paleo = "paleo"
    case primal = "primal"
    case whole30 = "whole30"
}
