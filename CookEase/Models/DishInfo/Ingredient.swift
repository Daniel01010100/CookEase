//
//  Ingredient.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import Foundation

struct Quantity: Codable {
    var amount: Double = 0.0    // Refer to "amount" in the json file.
    var unit: String    // Refer to the "unit" in the json file.
}

struct Ingredient: Codable, Identifiable {
    var ingredientID: UUID = UUID()   // Localised ingredient id.
    /* fetchIngredientInformation */
    var id: Int? = nil     // Refer to "id" in the json file.
    var name: String    //Refer to "name" in the json file.
    var image: String? = nil   // Refer to "image" in the json file.
    var categoryPath: [String]? = nil   // Refer to "categoryPath" in the json file.
    var amount: Quantity? = nil     // Refere to "amount" in the json file.
    var nutrition: Nutrition? = nil     // Refer to "nutrition" in the json file.
    /* Will be input by the user */
    var purchasedAt: Date? = nil
    /* It will be compared with categoryPath, and be assigned a value if they are matched. */
    var category: IngredientCategory? = nil
    
    mutating func getCategory() {
        if let path = self.categoryPath {
            for component in path {
                if let matchedCategory = IngredientCategory(rawValue: component) {
                    self.category = matchedCategory
                    break
                }
            }
        }
    }
}
