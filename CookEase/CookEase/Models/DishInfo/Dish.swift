//
//  Dish.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import Foundation

struct Dish: Codable, Identifiable {
    var id: UUID = UUID()   // Localised dish id.
    /* fetchRecipeInformation */
    var apiID: Int     // Refer to "id" in the json file.
    var title: String       // Refer to "title" in the json file.
    var imageName: String   // Refer to "image" in the json file.
    var servings: Int       // Refer to "servings" in the json file.
    var cookingTime: Int   // Refer to "readyInMinutes" in the json file (unit: minutes).
    var category: Cuisine   // Refer to "cuisines" in the json file.
    var estimatedNutrition: Nutrition? = nil    // Refer to "nutrients" in the json file.
    /* fetchRequiredIngredient */
    var ingredients: [Ingredient]   // Refer to "ingredients" in the json file.
    /* fetchRequiredEquipment */
    var requiredTools: [Equipment]  // Refer to "equipment" in the json file.
    /* Fulfilled by the self-created algorithm */
    var level: CookingSkill // It's not referenced from the json file.
}
