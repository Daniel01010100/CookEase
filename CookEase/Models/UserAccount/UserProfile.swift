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

struct UserProfile: Codable, Identifiable {
    var id: UUID = UUID()
    var nickname: String
    var email: String
    var avatar: String?
    var isLogin: Bool = false
    var cookingSkill: CookingSkill = .Basic
    var allergies: [String] = []
    var diet: String?
    var ownedTools: [Equipment] = []
    var existingIngredients: [Ingredient] = []
    var favouriteCuisines: [Dish] = []
    var dislikeCuisines: [Dish] = []
    var cookingHistory: [Dish] = []
}
