//
//  RecipeViewModel.swift
//  CookEase
//
//  Created by YUDONG LU on 22/8/2025.
//

import Foundation
import Observation

@Observable
class RecipeViewModel {
    private let cuisineRepository: CuisineAPIRepositoryProtocol
    
    init(repository: CuisineAPIRepositoryProtocol = CuisineAPIRepository()) {
        self.cuisineRepository = repository
    }
}
