//
//  UserProfile.swift
//  CookEase
//
//  Created by YUDONG LU on 17/8/2025.
//

import Foundation


struct UserProfile: Codable, Identifiable {
    var id: UUID  // User's id.
    var nickname: String    // User's nickname.
    var email: String       // User's email which is binded with password.
    var securityQuestion: String    // Used for authentication in password reset function.
    var securityAnswer: String
    var password: String
    var isLogin: Bool = false   // User's login status. true - is logged in; false - is logged out.
    var cookingSkill: CookingSkill?
    var diets: [Diet]?  // An array that stores user's dietary preference (optional).
    var intolerances: [Intolerance]?    // An array that stores user's intolerance or food allergies (optional).
    var ownedEquipment: [CommonEquipment]?    // An array that stores the equipment owned by the user(optional).
    var existingIngredients: [Ingredient]?  // An array that stores the ingredients the user has (optional).
    var dishStatus: [UUID: DishStatus] = [:]    // An dictionary that stores the user's dish preferences.
    
    init() {
        self.id = UUID()
        self.nickname = ""
        self.email = ""
        self.password = ""
        self.securityQuestion = ""
        self.securityAnswer = ""
    }
}

enum CookingSkill: Int, Codable {
    case Basic = 0      // Default status.
    case Intermediate = 1
    case Advanced = 2
}

typealias DishPreferenceType = DishStatus.PreferenceType

struct DishStatus: Codable {
    enum PreferenceType: Int, Codable {
        case none = 0       // Default status.
        case favourite = 1
        case dislike = 2
    }
    
    var preferenceType: PreferenceType = .none
    var isCookedBefore: Bool = false    // Store cooking history for users.
}
