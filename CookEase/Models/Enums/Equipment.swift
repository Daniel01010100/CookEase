//
//  Equipment.swift
//  CookEase
//
//  Created by YUDONG LU on 24/8/2025.
//

import Foundation

enum CommonEquipment: String, Codable {
    /* Heating */
    case fryingPan = "frying pan"
    case saucePan = "sauce pan"
    case bakingPan = "baking pan"
    case wok = "wok"
    case oven = "oven"
    case microwave = "microwave"
    case airFryer = "air fryer"
    case pressureCooker = "pressure cooker"
    case instantPot = "instant pot"
    case griddle = "griddle"
    case roastingPan = "roasting pan"
    case deepFryer = "deep fryer"
    case riceCooker = "rice cooker"
    case steamerBasket = "steamer basket"

    /* Cutting */
    case knife = "knife"
    case cuttingBoard = "cutting board"
    case peeler = "peeler"
    case grater = "grater"
    case boxGrater = "box grater"
    case mandoline = "mandoline"
    case cleaver = "cleaver"
    case meatGrinder = "meat grinder"

    /* Mixing */
    case mixingBowl = "mixing bowl"
    case bowl = "bowl"
    case spoon = "spoon"
    case whisk = "whisk"
    case spatula = "spatula"
    case handMixer = "hand mixer"
    case standMixer = "stand mixer"
    case foodProcessor = "food processor"
    case blender = "blender"

    /* Measurement */
    case measuringCup = "measuring cup"
    case measuringSpoon = "measuring spoon"
    case kitchenThermometer = "kitchen thermometer"
}

enum Equipment: Codable, Equatable {
    case standard   // Doesn't consider the impact of equipment while fetching the recipes.
    case common(CommonEquipment)    // The common equipment which is enumerated in the CommonEquipment Enum.
    case other(String)      // Uncovered cooking equipment in the Spoonacular API.
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawVal = try container.decode(String.self)
        if let standardEquipment = CommonEquipment(rawValue: rawVal) {
            self = .common(standardEquipment)
        } else {
            self = .other(rawVal)
        }
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .standard:
            break
        case .common(let val):
            try container.encode(val.rawValue)
        case .other(let val):
            try container.encode(val)
        }
    }
}

struct TemperatureInfo: Codable {
    var number: Int     // Refer to step - equipment - temperature - "number"
    var unit: String    // Refer to step - equipment - temperature - "unit"
}

struct EquipmentInfo: Codable {
    var equipmentID: UUID = UUID()      // Localised equipment id.
    /* fetchRequiredEquipment || fetchAnalysedRecipeInstructions */
    var id: Int? = nil  // Refer to step - equipment - "id" in the json file.
    var image: String?   // Refer to step - equipment - "image" in the json file.
    var name: Equipment?   // Refer to step - equipment - "name" in the json file.
    var temperature: TemperatureInfo?      // Refer to step - equipment - "temperature" in the json file.
}

