//
//  CuisineAPIRepository.swift
//  CookEase
//
//  Created by YUDONG LU on 20/8/2025.
//

import Foundation

protocol CuisineAPIRepositoryProtocol {
    /*
     @Brief
        Obtain recipes recommendation based on dish name, cuisine category, and available equipment.
     @Parameters
        query: The name of the recipe user may search;
        cuisine: The cuisine(s) of the recipe, comma-seperated as OR;
        excludeCuisine: The cuisine(s) the cipes must not match, comma-seperated as AND;
        diet: The diet(s) for which the recipes must be suitable, comma-seperated as OR, pipe-seperated as AND;
        intolerances: The list of intolerances that recipes must not contains, comma-seperated as AND;
        equipment: The equipment required, comma-seperated as OR;
        number: The amount of expected results (1 .. 100).
    */
    func fetchRecipes(_ query: String, _ diet: String, _ intolerances: String,
                      _ equipment: String, _ number: Int) async throws -> [Dish]
    
    /*
     @Brief
        Obtain the recipes recommendation based on available ingredients.
     
     @Parameters
        ingredients: A comma-separated list of ingredients that the recipes contain;
        number: The maximum amount of recipes to return (1...100);
        ranking: Whether to maximise used ingredients (1) or minimise missing ingredients (2);
        ignorePantry: Whether to ignore typical ingredient items, such as water, salt, etc.
    */
    func fetchRecipesByIngredients(_ ingredients: String, _ number: Int, _ ranking: Int, _ ignorePantry: Bool) async throws -> [Dish]
    
    /*
     @Brief
        Obtain full information about a recipe, such as ingredients, nutrition, etc.
     @Parameters
        recipeId: The id of the recipe;
        includeNutrition: Whether to include nutrition data in the recipe information (per serving).
    */
    func fetchRecipeInformation(_ recipeID: Int, _ includeNutrition: Bool) async throws -> Dish
    
    /*
     @Brief
        Obtain a list of required equipment for a recipe.
     @Parameters
        recipeID: The id of the recipe. Return all the used equipment to complete this dish.
    */
    func fetchRequiredEquipment(_ recipeID: Int) async throws -> [EquipmentInfo]
    
    /*
     @Brief
        Obtain a list of ingredients for a recipe.
     @Parameters
        recipeID: The id of the recipe.
    */
    func fetchRequiredIngredient(_ recipeID: Int) async throws -> [Ingredient]
    
    /*
     @Brief
        Obtain an analysed breakdown of a recipe's instructions. Each step contains the ingredients and equipment required.
     @Parameters
        recipeID: The id of the recipe;
        stepBreakdown: Whether to break down the recipe steps even more. (Suitable for user who has basic cooking skill)
    */
    func fetchAnalysedRecipeInstructions(_ recipeID: Int, _ stepBreakdown: Bool) async throws -> Instruction
    
    /*
     @Brief
        Use an ingredient id to get available information about it.
     @Parameters
        ingredientID: The id of the ingredient;
        amount: The amount of the ingredient;
        unit: The unit for given amount;
        locale: The returned data is in Britain English.
    */
    func fetchIngredientInfo(_ ingredientID: Int, _ amount: Int, _ unit: String, _ locale: String) async throws -> Ingredient
}

class CuisineAPIRepository: CuisineAPIRepositoryProtocol {
    private let apiKey = "10e3c96611c646a0a0b9e03a8d4671f7"
    private let urlSession = URLSession.shared
    
    func fetchRecipes(_ query: String = "", _ diet: String = "",
                      _ intolerances: String = "", _ equipment: String = "", _ number: Int = 5) async throws -> [Dish] {
        guard let url = SpoonacularEndpoint.searchRecipes(query: query, diet: diet,
                                                          intolerances: intolerances, equipment: equipment,
                                                          number: number).getURL(apiKey: apiKey)
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        guard let rawRecipes = jsonData?["results"] as? [[String: Any]] else {
            //throw CookEaseError.invalidJSON(errorInfo: "fetch recipes")
            return []
        }
        
        var recipes: [Dish] = []
        for rawRecipe in rawRecipes {
            var dish = Dish()
            dish.dishID = UUID()
            dish.id = rawRecipe["id"] as? Int ?? 0
            dish.title = rawRecipe["title"] as? String
            dish.image = rawRecipe["image"] as? String
            recipes.append(dish)
        }
        return recipes
    }
    
    func fetchRecipesByIngredients(_ ingredients: String, _ number: Int, _ ranking: Int, _ ignorePantry: Bool) async throws -> [Dish]
    {
        guard let url = SpoonacularEndpoint.searchRecipesByIngredients(ingredients: ingredients, number: number, ranking: ranking,
                                                                       ignorePantry: ignorePantry).getURL(apiKey: apiKey)
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        let result = try JSONDecoder().decode([Dish].self, from: data)
        return result;
    }
    
    func fetchRecipeInformation(_ recipeID: Int, _ includeNutrition: Bool) async throws -> Dish {
        guard let url = SpoonacularEndpoint.obtainRecipeInformation(id: recipeID,
                                                                    includeNutrition: includeNutrition).getURL(apiKey: apiKey)
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        let jsonData = try JSONSerialization.jsonObject(with: data) as? [String: Any]
        
        guard let recipeInfo = jsonData else {
            //throw CookEaseError.invalidJSON(errorInfo: "fetch recipe information")
            return Dish()
        }
        
        var dish = Dish()
        dish.id = dish.id == 0 ? recipeInfo["id"] as? Int ?? 0 : dish.id
        dish.title = recipeInfo["title"] as? String
        dish.image = recipeInfo["image"] as? String
        dish.servings = recipeInfo["servings"] as? Int
        dish.readyInMinutes = recipeInfo["readyInMinutes"] as? Int
        return dish
    }
    
    func fetchRequiredEquipment(_ recipeID: Int) async throws -> [EquipmentInfo] {
        guard let url = SpoonacularEndpoint.obtainRequiredEquipment(id: recipeID).getURL(apiKey: apiKey)
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        let result = try JSONDecoder().decode([EquipmentInfo].self, from: data)
        return result
    }
    
    func fetchRequiredIngredient(_ recipeID: Int) async throws -> [Ingredient] {
        guard let url = SpoonacularEndpoint.obtainRequiredIngredient(id: recipeID).getURL(apiKey: apiKey)
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        let result = try JSONDecoder().decode([Ingredient].self, from: data)
        return result
    }
    
    func fetchAnalysedRecipeInstructions(_ recipeID: Int, _ stepBreakdown: Bool) async throws -> Instruction {
        guard let url = SpoonacularEndpoint.obtainAnalysedRecipeInstruction(id: recipeID,
                                                                     stepBreakdown: stepBreakdown).getURL(apiKey: apiKey)
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        var instructionResult = Instruction()
        var steps: [CookingStep] = []
        
        let jsonData = try JSONSerialization.jsonObject(with: data) as? [[String: Any]]
        guard let firstSection = jsonData?.first,
              let rawSteps = firstSection["steps"] as? [[String: Any]] else {
            return instructionResult
        }
        
        for rawStep in rawSteps {
            var step = CookingStep()
            
            step.number = rawStep["number"] as? Int
            step
        }
        return instructionResult
    }
    
    func fetchIngredientInfo(_ ingredientID: Int, _ amount: Int, _ unit: String, _ locale: String) async throws -> Ingredient {
        guard let url = SpoonacularEndpoint.obtainIngredientInformation(id: ingredientID, amount: amount, unit: unit,
                                                                        locale: locale).getURL(apiKey: apiKey)
        else {
            throw URLError(.badURL)
        }
        let (data, _) = try await urlSession.data(from: url)
        let result = try JSONDecoder().decode(Ingredient.self, from: data)
        return result
    }
}
