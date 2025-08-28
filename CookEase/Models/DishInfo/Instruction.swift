//
//  Instruction.swift
//  CookEase
//
//  Created by YUDONG LU on 21/8/2025.
//

import Foundation

struct CookingStep: Decodable {
    var equipment: [EquipmentInfo]?   // Refer to "equipment" in the json file.
    var ingredients: [Ingredient]? // Refer to "ingredients" in the json file.
    var number: Int     // Refer to "number" in the json file.
    var step: String    // Refer to "step" in the json file.
}

struct Instruction: Decodable {
    var name: String  // Refer to "name" in the json file.
    var steps: [CookingStep] = []   // Refer to "steps" in the json file.
}
