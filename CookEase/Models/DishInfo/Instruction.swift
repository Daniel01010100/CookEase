//
//  Instruction.swift
//  CookEase
//
//  Created by YUDONG LU on 21/8/2025.
//

import Foundation

struct CookingTime: Decodable {
    var number: Int     // Refer to "steps - length - number" in the json file.
    var unit: String    // Refer to "steps - length - unit" in the json file.
}

struct CookingStep: Decodable {
    var equipment: [EquipmentInfo]?   // Refer to "steps - equipment" in the json file.
    var ingredients: [Ingredient]? // Refer to "steps - ingredients" in the json file.
    var length: CookingTime?    // Refer to "steps - length" in the json file.
    var number: Int     // Refer to "steps - number" in the json file.
    var step: String    // Refer to "steps - step" in the json file.
}

struct Instruction: Decodable {
    var steps: [CookingStep] = []   // Refer to "steps" in the json file.
}
