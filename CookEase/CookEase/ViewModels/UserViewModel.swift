//
//  UserViewModel.swift
//  CookEase
//
//  Created by YUDONG LU on 20/8/2025.
//

import Foundation

@Observable
class UserViewModel {
    var userProfile: UserProfile
    
    func signUp(_ email: String, _ password: String) throws {
        if (email.isEmpty || password.isEmpty) {
            throw CookEaseError.emptyEmailOrPassword
        }
        if (!email.isValidEmail) {
            throw CookEaseError.invalidEmailFormat
        }
        
        self.userProfile.email = email
        try AccountSecurity.savePassword(password, for: email)
    }
    
    func signIn(_ email: String, _ password: String) throws {
        if (email.isEmpty || password.isEmpty) {
            throw CookEaseError.emptyEmailOrPassword
        }
        if (!email.isValidEmail) {
            throw CookEaseError.invalidEmailFormat
        }
        
        let savedPassword = try AccountSecurity.retrievePassword(for: email)
        if (password == savedPassword) {
            self.userProfile.isLogin = true
        } else {
            throw CookEaseError.invalidCredentials
        }
    }
    
    func signOut() {
        self.userProfile.isLogin = false
    }
    
    
    func setNickName(_ nickName: String) {
        self.userProfile.nickname = nickName
    }
    
    func setCookingSkill(_ skill: CookingSkill) {
        self.userProfile.cookingSkill = skill
    }
    
    func addDietaryPreference(_ diet: Diet) {
        guard var dietsList = self.userProfile.diets else {
            self.userProfile.diets = [diet]
            return
        }
        if (!dietsList.contains(diet)) {
            dietsList.append(diet)
            self.userProfile.diets = dietsList
        }
    }
    
    func deleteDietaryPreference(_ diet: Diet) throws {
        guard var dietsList = self.userProfile.diets else {
            throw CookEaseError.emptyDataSource(errorInfo: "diet")
        }
        if (!dietsList.contains(diet)) {
            throw CookEaseError.itemNotFound(errorInfo: "diet")
        }
        dietsList.removeAll { $0 == diet }
        self.userProfile.diets = dietsList
    }
    
    func addIntolerance(_ intolerance: Intolerance) {
        guard var intoList = self.userProfile.intolerances else {
            self.userProfile.intolerances = [intolerance]
            return
        }
        if (!intoList.contains(intolerance)) {
            intoList.append(intolerance)
            self.userProfile.intolerances = intoList
        }
    }
    
    func deleteIntolerance(_ intolerance: Intolerance) throws {
        guard var intoList = self.userProfile.intolerances else {
            throw CookEaseError.emptyDataSource(errorInfo: "intolerance")
        }
        if (!intoList.contains(intolerance)) {
            throw CookEaseError.itemNotFound(errorInfo: "intolerance")
        }
        intoList.removeAll { $0 == intolerance }
        self.userProfile.intolerances = intoList
    }
    
    func addOwnedquipment(_ equipment: Equipment) {
        guard var tools = self.userProfile.ownedEquipment else {
            self.userProfile.ownedEquipment = [equipment]
            return
        }
        if (!tools.contains(equipment)) {
            tools.append(equipment)
            self.userProfile.ownedEquipment = tools
        }
    }
    
    func deleteOwnedEquipment(_ equipment: Equipment) throws {
        guard var tools = self.userProfile.ownedEquipment else {
            throw CookEaseError.emptyDataSource(errorInfo: "equipment")
        }
        if (!tools.contains(equipment)) {
            throw CookEaseError.itemNotFound(errorInfo: "equipment")
        }
        tools.removeAll { $0 == equipment }
        self.userProfile.ownedEquipment = tools
    }
    
    func addExistingIngredients(_ name: String, _ amount: Double, _ unit: String, _ purchasedAt: Date? = nil) {

    }
    
    func modifyIngredients(_ amount: Double, _ unit: String, _ purchasedAt: Date? = nil) {
        
    }
    
    func deleteExistingIngredients(_ name: String) throws {
        
    }
    
    func updateCuisinePreference(_ cuisine: Cuisine, preferenceType: PreferenceType) {
        self.userProfile.cuisinePreference[cuisine] = preferenceType
    }
    
    func updateDishPreference(_ dishID: UUID, preferenceType: PreferenceType? = nil, isCookedBefore: Bool? = nil) {
        var currentPreference = self.userProfile.dishPreference[dishID] ?? DishPreference()
        
        if let prefernce = preferenceType {
            currentPreference.preferenceType = prefernce
        }
        
        if let isCooked = isCookedBefore {
            currentPreference.isCookedBefore = isCooked
        }
        
        self.userProfile.dishPreference[dishID] = currentPreference
    }
    
    
    
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
