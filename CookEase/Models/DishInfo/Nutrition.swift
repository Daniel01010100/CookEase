//
//  Nutrition.swift
//  CookEase
//
//  Created by YUDONG LU on 20/8/2025.
//

import Foundation

struct Nutrition: Codable {
    var nutrients: [Nutrient]
}

struct Nutrient: Codable {
    var name: String    // Refer to "name" in the json file.
    var amount: Double  // Refer to "amount" in the json file.
    var unit: String    // Refer to "unit" in the json file.
    var percentOfDailyNeeds: Double     // Refer to "percentOfDailyNeeds" in the json file.
}
