//
//  UserProfile.swift
//  CookEase
//
//  Created by YUDONG LU on 17/8/2025.
//

import Foundation

enum CookingSkill: Int, Codable {
    case Basic = 0
    case Intermediate = 1
    case Advanced = 2
}

enum PreferenceType: Int, Codable {
    case none = 0
    case favourite = 1
    case dislike = 2
}

struct DishPreference: Codable {
    var preferenceType: PreferenceType = .none
    var isCookedBefore: Bool = false
}

struct UserProfile: Codable, Identifiable {
    var id: UUID = UUID()   // User's id.
    var nickname: String    // User's nickname.
    var email: String       // User's email which is binded with password.
    var isLogin: Bool = false   // User's login status. true - is logged in; false - is logged out.
    var cookingSkill: CookingSkill = .Basic
    var diets: [Diet]?  // An array that stores user's dietary preference (optional).
    var intolerances: [Intolerance]?    // An array that stores user's intolerance or food allergies (optional).
    var ownedEquipment: [Equipment]?    // An array that stores the equipment owned by the user(optional).
    var existingIngredients: [Ingredient]?  // An array that stores the ingredients the user has (optional).
    var cuisinePreference: [Cuisine: PreferenceType] = [:]  // An dictionary that stores the user's cuisine preferences.
    var dishPreference: [UUID: DishPreference] = [:]    // An dictionary that stores the user's dish preferences.
}
