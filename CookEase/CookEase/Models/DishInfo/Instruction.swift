//
//  Instruction.swift
//  CookEase
//
//  Created by YUDONG LU on 21/8/2025.
//

import Foundation

struct EquipmentInfo: Decodable {
    var id: UUID = UUID()   // Localised equipment id.
    /* fetchRequiredEquipment || fetchAnalysedRecipeInstructions */
    var apiID: Int      // Refer to "id" in the json file.
    var imageName: String   // Refer to "image" in the json file.
    var name: Equipment     // Refer to "name" in the json file.
    var status: String      // Refer to the data such as "temperature".
}

struct CookingStep: Decodable {
    var number: Int     // Refer to "number" in the json file.
    var task: String    // Refer to "step" in the json file.
    var equipment: [EquipmentInfo]?   // Refer to "equipment" in the json file.
    var requiredIngredients: [Ingredient]? // Refer to "ingredients" in the json file.
}

struct Instruction: Decodable {
    var title: String  // Refer to "name" in the json file.
    var steps: [CookingStep] = []   // Refer to "steps" in the json file.
}
