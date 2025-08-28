//
//  CookEaseViewModel.swift
//  CookEase
//
//  Created by YUDONG LU on 16/8/2025.
//

import Observation

@Observable
class CookEaseViewModel {
    var userVM: UserViewModel
    var cuisineAPI: CuisineAPIRepository = CuisineAPIRepository()
    
    func generateRecipesBasedOnIngredients(_ ingredients: [Ingredient], _ number: Int) async throws -> [Dish] {
        var ingredientsInfo = ""
        var recipes: [Dish] = []
        for ingredient in ingredients {
            ingredientsInfo += "\(ingredient.name),"
        }
        if (ingredientsInfo.suffix(1) == ",") {
            ingredientsInfo.removeLast()
        }
        recipes = try await cuisineAPI.fetchRecipesByIngredients(ingredientsInfo, number, 2, true)
        return recipes
    }
    
    func fetchInstructionForRecipe(_ recipeAPIID: Int) async throws -> Instruction {
        let isBreakdown = userVM.getUserCookingSkill() == .Basic ? true : false
        var instruction = try await cuisineAPI.fetchAnalysedRecipeInstructions(recipeAPIID, isBreakdown)
        return instruction
    }
    
    func generateRecipes(_ dishName: String, _ number: Int) async throws -> [Dish] {
        var favouritesCuisine: String = ""
        var dislikeCuisine: String = ""
        var dietInfo: String = ""
        var intoleranceInfo: String = ""
        var equipmentInfo: String = ""
        
        var recipes: [Dish] = []
        
        var cuisines = userVM.getUserCuisinePreference()
        for (key, value) in cuisines {
            if (value == .favourite) {
                favouritesCuisine += "\(key),"
            } else if (value == .dislike) {
                dislikeCuisine += "\(key),"
            }
        }
        if (favouritesCuisine.suffix(1) == ",") {
            favouritesCuisine.removeLast()
        }
        if (dislikeCuisine.suffix(1) == ",") {
            dislikeCuisine.removeLast()
        }
        
        var diets = userVM.getUserDietaryPreferences()
        for diet in diets {
            if (diet == .standard) { continue }
            dietInfo += "\(diet),"
        }
        if (dietInfo.suffix(1) == ",") {
            dietInfo.removeLast()
        }
        
        var intolerances = userVM.getUserIntolerances()
        for intolerance in intolerances {
            if (intolerance == .none) { continue }
            intoleranceInfo += "\(intolerance),"
        }
        if (intoleranceInfo.suffix(1) == ",") {
            intoleranceInfo.removeLast()
        }
        
        var tools = userVM.getUserOwnedEquipment()
        for equipment in tools {
            if (equipment == .standard) { continue }
            equipmentInfo += "\(equipment),"
        }
        if (equipmentInfo.suffix(1) == ",") {
            equipmentInfo.removeLast()
        }
        
        recipes = try await cuisineAPI.fetchRecipes(dishName, favouritesCuisine, dislikeCuisine, dietInfo, intoleranceInfo,
                                         equipmentInfo, number)
        return recipes
    }
    
    
    init() {
        self.userVM = .init()
    }
    
}

