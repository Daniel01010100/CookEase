//
//  Dish.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import Foundation

struct Dish: Codable, Identifiable {
    var dishID: UUID = UUID()   // Localised dish id.
    /* fetchRecipeInformation() || fetchRecipes() || fetchRecipesByIngredients() */
    var id: Int = 0     // Refer to "id" in the json file.
    var title: String? = nil       // Refer to "title" in the json file.
    var image: String? = nil   // Refer to "image" in the json file.
    /* fetchRecipeInformation */
    var servings: Int? = nil       // Refer to "servings" in the json file.
    var readyInMinutes: Int? = nil   // Refer to "readyInMinutes" in the json file (unit: minutes).
    var cuisines: Cuisine? = nil   // Refer to "cuisines" in the json file.
    /* fetchRequiredEquipment() */
    var equipment: [Equipment]? = nil  // Refer to "equipment" in the json file.
    /* fetchRequiredIngredient() */
    var ingredients: [Ingredient]? = nil   // Refer to "ingredients" in the json file.
    /* Fulfilled by the self-created algorithm */
    var level: CookingSkill? = nil // It's not referenced from the json file.
}

struct DishResult: Codable {
    /* fetchRcipes() */
    let results: [Dish]     // The search results returned by the API.
}
