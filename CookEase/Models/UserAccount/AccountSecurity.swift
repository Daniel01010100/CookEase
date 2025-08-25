//
//  Account.swift
//  CookEase
//
//  Created by YUDONG LU on 18/8/2025.
//

import Foundation
import Security

enum Keychain {
    static let service = "CookEase"
    
    static func savePassword(_ password: String, for email: String) throws {
        let data = Data(password.utf8)
        
        let deleteQuery: [String]
    }
}
