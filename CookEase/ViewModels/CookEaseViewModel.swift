//
//  CookEaseViewModel.swift
//  CookEase
//
//  Created by YUDONG LU on 16/8/2025.
//

import Observation
import SwiftUI

@Observable
class CookEaseViewModel {
    var userVM: UserViewModel
    var cuisineAPI: CuisineAPIRepository = CuisineAPIRepository()
    var navPath: [AuthRoute] = []
    var recommendRecipe: [Dish] = []
    
    let cookEaseThemeColour = Color(red: 1.0, green: 0.4, blue: 0.0)
    
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
    
    // Equals to fetchRecipes() + fetchRecipeInformation()
    func generateRecipes(_ query: String, _ number: Int, _ isPersonalised: Bool = true) async {
        let queryInfo = query.lowercased()
        if (isPersonalised) {
            var dietInfo: String = ""
            var intoleranceInfo: String = ""
            var equipmentInfo: String = ""
                        
            let diets = userVM.getUserDietaryPreferences()
            for diet in diets {
                if (diet == .standard) { continue }
                dietInfo += "\(diet),"
            }
            if (dietInfo.suffix(1) == ",") {
                dietInfo.removeLast()
            }
            
            let intolerances = userVM.getUserIntolerances()
            for intolerance in intolerances {
                if (intolerance == .none) { continue }
                intoleranceInfo += "\(intolerance),"
            }
            if (intoleranceInfo.suffix(1) == ",") {
                intoleranceInfo.removeLast()
            }
            
            let tools = userVM.getUserOwnedEquipment()
            for equipment in tools {
                if (equipment == .standard) { continue }
                equipmentInfo += "\(equipment),"
            }
            if (equipmentInfo.suffix(1) == ",") {
                equipmentInfo.removeLast()
            }
            
            do {
                self.recommendRecipe = try await cuisineAPI.fetchRecipes(queryInfo, dietInfo, intoleranceInfo, equipmentInfo, number)
            } catch {
                print("Failed to fetch recipes: \(error)")
            }
        } else {
            do {
                self.recommendRecipe = try await cuisineAPI.fetchRecipes(queryInfo, "", "", "", number)
            } catch {
                print("Failed to fetch recipes: \(error)")
            }
        }
        
        var updatedDishes: [Dish] = []
        for dish in self.recommendRecipe {
            do {
                let updatedDish = try await self.cuisineAPI.fetchRecipeInformation(dish.id, false)
                updatedDishes.append(updatedDish)
            } catch {
                print("Failed to fetch info for dish id \(dish.id): \(error)")
                updatedDishes.append(dish)
            }
        }
        self.recommendRecipe = updatedDishes
    }
    
    
    init() {
        self.userVM = .init()
    }
    
}

extension CookEaseViewModel {
    var isUserLoggedIn: Bool {
        return self.userVM.userProfile.isLogin
    }
    
    func setUserLoggenInStatus(_ status: Bool) {
        self.userVM.userProfile.isLogin = status
    }
}

