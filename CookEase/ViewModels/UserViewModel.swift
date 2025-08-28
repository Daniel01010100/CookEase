//
//  UserViewModel.swift
//  CookEase
//
//  Created by YUDONG LU on 20/8/2025.
//

import Foundation

@Observable
class UserViewModel {
    var userProfile: UserProfile = UserProfile()    // The default value of userProfile will be overwritten in the sign-up function.
    
    /*
     @Brief
        Provides registration functionality, saves the user's email account to userProfile.
     @Parameters
        email: Account registration email.
        password: The password which is bundled with user's email address.
     */
    func signUp(_ email: String, _ password: String) -> Bool {
        if (email.isEmpty || password.isEmpty) {
            return false
        }
        if (!email.isValidEmail) {
            return false
        }
        
        self.userProfile.email = email
        self.userProfile.password = password
        return true
    }
    
    func signIn(_ email: String, _ password: String) -> Bool {
        if (email.isEmpty || password.isEmpty) {
            return false
        }
       
        if (email == self.userProfile.email && password == self.userProfile.password) {
            self.userProfile.isLogin = true
            return true
        } else {
            return false
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
    
    func getUserCookingSkill() -> CookingSkill {
        return self.userProfile.cookingSkill ?? .Basic
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
    
    func getUserDietaryPreferences() -> [Diet] {
        return self.userProfile.diets ?? [.standard]
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
    
    func getUserIntolerances() -> [Intolerance] {
        return self.userProfile.intolerances ?? [.none]
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
    
    func getUserOwnedEquipment() -> [Equipment] {
        return self.userProfile.ownedEquipment ?? [.standard]
    }
    
    func insertIngredients(_ ingredientID: UUID, _ name: String, _ amount: Double, _ unit: String,
                                _ purchasedAt: Date? = nil) throws {
        let newIngredient = Ingredient(
            id: ingredientID,
            name: name,
            quantity: Quantity(amount: amount, unit: unit),
            purchasedAt: purchasedAt
        )
        
        if var ingredients = self.userProfile.existingIngredients {
            guard !ingredients.contains(where: { $0.id == ingredientID }) else {
                throw CookEaseError.duplicateItem(errorInfo: "ingredient")
            }
            ingredients.append(newIngredient)
            self.userProfile.existingIngredients = ingredients
        } else {
            self.userProfile.existingIngredients = [newIngredient]
        }
    }
    
    func updateIngredientsByID(_ ingredientID: UUID, _ name: String, _ amount: Double, _ unit: String,
                               _ purchasedAt: Date? = nil) throws {
        guard var ingredients = self.userProfile.existingIngredients else {
            throw CookEaseError.emptyDataSource(errorInfo: "ingredients")
        }
        if let idx = ingredients.firstIndex(where: { $0.id == ingredientID }) {
            if (ingredients[idx].name != name ||
               ingredients[idx].quantity?.amount != amount ||
               ingredients[idx].quantity?.unit != unit ||
               ingredients[idx].purchasedAt != purchasedAt) {
                
                ingredients[idx].name = name
                ingredients[idx].quantity = Quantity(amount: amount, unit: unit)
                ingredients[idx].purchasedAt = purchasedAt
                self.userProfile.existingIngredients = ingredients
            }
        } else {
            throw CookEaseError.itemNotFound(errorInfo: "ingredient")
        }
    }
    
    func deleteIngredients(_ ingredientID: UUID) throws {
        guard var ingredients = self.userProfile.existingIngredients else {
            throw CookEaseError.emptyDataSource(errorInfo: "ingredients")
        }
        
        guard ingredients.contains(where: { $0.id == ingredientID}) else {
            throw CookEaseError.itemNotFound(errorInfo: "ingredient")
        }
        
        ingredients.removeAll { $0.id == ingredientID }
        self.userProfile.existingIngredients = ingredients
    }
    
    func getUserExistingIngredients() throws -> [Ingredient] {
        return self.userProfile.existingIngredients ?? []
    }
    
    func updateCuisinePreference(_ cuisine: Cuisine, preferenceType: PreferenceType) {
        self.userProfile.cuisinePreference[cuisine] = preferenceType
    }
    
    func getUserCuisinePreference() -> [Cuisine: PreferenceType] {
        return self.userProfile.cuisinePreference
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
    
    func getUserDishPreference() -> [UUID: DishPreference] {
        return self.userProfile.dishPreference
    }
    
    func saveUserProfile() throws {
        let jsonEncoder = JSONEncoder()
        guard let userData = try? jsonEncoder.encode(self.userProfile) else {
            throw CookEaseError.jsonCodingFailed(errorInfo: "userProfile")
        }
        
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("userProfile.json") else {
            throw CookEaseError.invalidURL(errorInfo: "userProfile.json")
        }
        
        do {
            try userData.write(to: fileURL)
        } catch {
            throw CookEaseError.saveDataFailed(errorInfo: "userProfile.json")
        }
    }
    
    func loadUserProfile() throws {
        let jsonDecoder = JSONDecoder()
        guard let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("userProfile.json") else {
            throw CookEaseError.invalidURL(errorInfo: "userProfile.json")
        }
        
        do {
            let userData = try Data(contentsOf: fileURL)
            self.userProfile = try jsonDecoder.decode(UserProfile.self, from: userData)
        } catch {
            throw CookEaseError.jsonDecodingFailed(errorInfo: "userProfile")
        }
    }
}

extension String {
    var isValidEmail: Bool {
        let emailRegex = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
