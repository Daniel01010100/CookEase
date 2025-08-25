//
//  AccountSecurity.swift
//  CookEase
//
//  Created by YUDONG LU on 18/8/2025.
//

import Foundation
import Security

enum AccountSecurity {
    static let service = "CookEase"
    
    static func savePassword(_ password: String, for email: String) throws {
        let passwordData = Data(password.utf8)
        
        let deleteQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecAttrService as String: service
        ]
        
        SecItemDelete(deleteQuery as CFDictionary)
        
        let addQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecAttrService as String: service,
            kSecValueData as String: passwordData
        ]
        
        let status = SecItemAdd(addQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw CookEaseError.keychainUnhandledError(status: status)
        }
    }
    
    static func retrievePassword(for email: String) throws -> String {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: email,
            kSecAttrService as String: service,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess else {
            if (status == errSecItemNotFound) {
                throw CookEaseError.keychainItemNotFound
            } else {
                throw CookEaseError.keychainUnhandledError(status: status)
            }
        }
        guard let passwordData = item as? Data,
              let password = String(data: passwordData, encoding: .utf8) else {
            throw CookEaseError.conversionFailed
        }
        
        return password
    }
}
