//
//  Ingredient.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import Foundation

struct Ingredient: Codable, Identifiable {
    var ingredientID: UUID = UUID()  // Localised ingredient id.
    /* fetchIngredientInformation */
    var id: Int = 0     // Refer to "id" in the json file.
    var name: String? = nil    //Refer to "name" in the json file.
    var image: String? = nil   // Refer to "image" in the json file.
    var categoryPath: [String]? = nil   // Refer to "categoryPath" in the json file.
    var amount: Double? = nil     // Refer to "amount" in the json file.
    var unit: String? = nil     // Refer to "unit" in the json file.
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

struct RequiredIngredients: Codable {
    /* Ingredient by ID */
    var amount: AmountInfo? = nil
    var name: String? = nil     // Refer to "name" in the json file.
}

struct AmountInfo: Codable {
    var metric: AmountUnit? = nil
    var us: AmountUnit? = nil
}

struct AmountUnit: Codable {
    var unit: String? = nil
    var value: Double? = nil
}
