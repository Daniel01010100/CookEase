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
    var amount: Double = 0.0
    var unit: String
}

struct Ingredient: Codable, Identifiable {
    var id: Int
    var name: String
    var imageName: String
    var purchasedAt: Date? = nil
    var category: IngredientCategory
    var quantity: Quantity? = nil
    var storageLocation: StorageLocation? = nil
    var nutrition: Nutrition? = nil
}
