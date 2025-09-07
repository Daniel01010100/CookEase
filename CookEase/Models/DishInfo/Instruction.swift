//
//  Instruction.swift
//  CookEase
//
//  Created by YUDONG LU on 21/8/2025.
//

import Foundation


struct Instruction: Codable {
    var steps: [CookingStep] = []   // Refer to "steps" in the json file.
}

struct CookingStep: Codable, Identifiable {
    var id: UUID = UUID()   // Used to conform Identifiable
    var equipment: [EquipmentInfo]? = nil   // Refer to "steps - equipment" in the json file.
    var ingredients: [Ingredient]? = nil // Refer to "steps - ingredients" in the json file.
    var length: CookingTime? = nil    // Refer to "steps - length" in the json file.
    var number: Int = 0    // Refer to "steps - number" in the json file.
    var step: String? = nil    // Refer to "steps - step" in the json file.
}

struct CookingTime: Codable {
    var number: Int = 0     // Refer to "steps - length - number" in the json file.
    var unit: String? = nil    // Refer to "steps - length - unit" in the json file.
}
