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
    var recipeInstruction: Instruction = Instruction()
    
    let cookEaseThemeColour = Color(red: 1.0, green: 0.4, blue: 0.0)
    
    func generateRecipesBasedOnIngredients(_ ingredients: [Ingredient], _ number: Int) async throws -> [Dish] {
        var ingredientsInfo = ""
        var recipes: [Dish] = []
        for ingredient in ingredients {
            ingredientsInfo += "\(ingredient.name ?? ""),"
        }
        if (ingredientsInfo.suffix(1) == ",") {
            ingredientsInfo.removeLast()
        }
        recipes = try await cuisineAPI.fetchRecipesByIngredients(ingredientsInfo, number, 2, true)
        return recipes
    }
    
    func fetchInstructionForRecipe(_ recipeAPIID: Int) async {
        let isBreakdown = userVM.getUserCookingSkill() == .Basic ? true : false
        do {
            self.recipeInstruction = try await cuisineAPI.fetchAnalysedRecipeInstructions(recipeAPIID, isBreakdown)
        } catch {
            print("Error occurred: \(error)")
        }
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
            print(dietInfo)
            
            let intolerances = userVM.getUserIntolerances()
            for intolerance in intolerances {
                if (intolerance == .none) { continue }
                intoleranceInfo += "\(intolerance),"
            }
            if (intoleranceInfo.suffix(1) == ",") {
                intoleranceInfo.removeLast()
            }
            print(intoleranceInfo)
            
            /*
            let tools = userVM.getUserOwnedEquipment()
            for equipment in tools {
                if (equipment == .standard) { continue }
                equipmentInfo += "\(equipment),"
            }
            if (equipmentInfo.suffix(1) == ",") {
                equipmentInfo.removeLast()
            }
             */
            
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
        self.saveDishToLocalJSON()
    }
    
    func saveDishToLocalJSON(_ fileName: String = "DishList.json") {
        let encoder = JSONEncoder()

        do {
            let jsonData = try encoder.encode(self.recommendRecipe)
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            try jsonData.write(to: url)
            print("Saved dish to list \(url)")
        } catch {
            print("Failed to save dish list: \(error)")
        }
    }
    
    func loadDishFromLocalJSON(_ fileName: String = "DishList.json") {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let recipe = try decoder.decode([Dish].self, from: jsonData)
            self.recommendRecipe = recipe
        } catch {
            print("Failed to load local dish")
            self.recommendRecipe = []
        }
    }
    
    func saveInstructionToLocalJSON(_ fileName: String = "Instruction.json") {
        let encoder = JSONEncoder()
        
        do {
            let jsonData = try encoder.encode(self.recipeInstruction)
            let url = getDocumentsDirectory().appendingPathComponent(fileName)
            try jsonData.write(to: url)
            print("Saved instruction to list \(url)")
        } catch {
            print("Failed to save instruction: \(error)")
        }
    }
    
    func loadInstructionToLocalJSON(_ fileName: String = "Instruction.json") {
        let url = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            self.recipeInstruction = try decoder.decode(Instruction.self, from: jsonData)
        } catch {
            print("Failed to load local instruction")
            self.recipeInstruction = Instruction()
        }
    }
    
    
    func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
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

