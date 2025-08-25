//
//  SpoonacularEndpoint.swift
//  CookEase
//
//  Created by YUDONG LU on 24/8/2025.
//

import Foundation

enum SpoonacularEndpoint {
    case searchRecipes(query: String, cuisine: String, excludeCuisine: String, diet: String, intolerances: String,
                       equipment: String, number: Int = 1)  // Identical
    
    case searchRecipesByIngredients(ingredients: String, number: Int = 1, ranking: Int = 2, ignorePantry: Bool = true)  // Identical
    
    case obtainRecipeInformation(id: Int, includeNutrition: Bool = true)    // Equals to 'Get Recipe information'
    
    case obtainRequiredEquipment(id: Int)   // Equals to 'Equipment by ID'
    
    case obtainRequiredIngredient(id: Int)   // Equals to 'Ingredients by ID'
        
    case obtainAnalysedRecipeInstruction(id: Int, stepBreakdown: Bool = false)  //  Equals to 'Get Analyzed Recipe Instructions'
    
    case obtainIngredientInformation(id: Int, amount: Int = 1, unit: String,
                                     locale: String = "en-GB")    // Equals to 'Get Ingredient Information'

    
    var path: String {
        switch self {
        case .searchRecipes:
            return "/recipes/complexSearch"
        case .searchRecipesByIngredients:
            return "/recipes/findByIngredients"
        case .obtainRecipeInformation(let id, _):
            return "/recipes/\(id)/information"
        case .obtainRequiredEquipment(id: let id):
            return "/recipes/\(id)/equipmentWidget.json"
        case .obtainRequiredIngredient(id: let id):
            return "/recipes/\(id)/ingredientWidget.json"
        case .obtainAnalysedRecipeInstruction(id: let id, _):
            return "/recipes/\(id)/analyzedInstructions"
        case .obtainIngredientInformation(id: let id, _, _, _):
            return "/food/ingredients/\(id)/information"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .searchRecipes(let query, let cuisine, let excludeCuisine, let diet, let intolerances, let equipment, let number):
            return [
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "cuisine", value: cuisine),
                URLQueryItem(name: "excludeCuisine", value: excludeCuisine),
                URLQueryItem(name: "diet", value: diet),
                URLQueryItem(name: "intolerances", value: intolerances),
                URLQueryItem(name: "equipment", value: equipment),
                URLQueryItem(name: "number", value: "\(number)")
            ]
            
        case .searchRecipesByIngredients(let ingredients, let number, let ranking, let ignorePantry):
            return [
                URLQueryItem(name: "ingredients", value: ingredients),
                URLQueryItem(name: "number", value: "\(number)"),
                URLQueryItem(name: "ranking", value: "\(ranking)"),
                URLQueryItem(name: "ignorePantry", value: ignorePantry ? "true" : "false")
            ]
            
        case .obtainRecipeInformation(let id, let includeNutrition):
            return [
                URLQueryItem(name: "id", value: "\(id)"),
                URLQueryItem(name: "includeNutrition", value: includeNutrition ? "true" : "false")
            ]
            
        case .obtainRequiredEquipment(let id):
            return [
                URLQueryItem(name: "id", value: "\(id)")
            ]
        
        case .obtainRequiredIngredient(let id):
            return [
                URLQueryItem(name: "id", value: "\(id)")
            ]
            
        case .obtainAnalysedRecipeInstruction(let id, let stepBreakdown):
            return [
                URLQueryItem(name: "id", value: "\(id)"),
                URLQueryItem(name: "stepBreakdown", value: stepBreakdown ? "true" : "false")
            ]
            
        case .obtainIngredientInformation(let id, let amount, let unit, let locale):
            return [
                URLQueryItem(name: "id", value: "\(id)"),
                URLQueryItem(name: "amount", value: "\(amount)"),
                URLQueryItem(name: "unit", value: unit),
                URLQueryItem(name: "locale", value: locale)
            ]
        }
    }
    
    func getURL(apiKey: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = "/\(path)"
        components.queryItems = queryItems + [URLQueryItem(name: "apiKey", value: apiKey)]
        return components.url
    }
}
