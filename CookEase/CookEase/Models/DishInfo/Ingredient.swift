//
//  Ingredient.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import Foundation

enum StorageLocation: String, Codable {
    case fridge     // Approximately 4 celsius degrees
    case freezer    // Approximately -18 celsius degrees
    case pantry     // Room temperature
}

struct Quantity: Codable {
    var amount: Double = 0.0    // Refer to "amount" in the json file.
    var unit: String    // Refer to the "unit" in the json file.
}

struct Ingredient: Codable, Identifiable {
    var id: UUID = UUID()   // Localised ingredient id.
    /* fetchIngredientInformation */
    var apiID: Int     // Refer to "id" in the json file.
    var name: String    //Refer to "name" in the json file.
    var imageName: String   // Refer to "image" in the json file.
    var category: IngredientCategory    // Refer to "categoryPath" in the json file.
    var quantity: Quantity? = nil
    var nutrition: Nutrition? = nil     // Refer to "nutrients" in the json file.
    /* Will be estimated by the app */
    var storageLocation: StorageLocation? = nil
    /* Will be input by the user */
    var purchasedAt: Date? = nil
}
