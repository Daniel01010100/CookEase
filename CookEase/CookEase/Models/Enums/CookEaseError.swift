//
//  CookEaseError.swift
//  CookEase
//
//  Created by YUDONG LU on 25/8/2025.
//

import Foundation

enum CookEaseError: Error {
    case keychainUnhandledError(status: OSStatus)
    case keychainItemNotFound
    case conversionFailed   // Failed to convert variable.
    case emptyEmailOrPassword
    case invalidEmailFormat
    case invalidCredentials
    case emptyDataSource(errorInfo: String)    // Target data is empty
    case itemNotFound(errorInfo: String)   // Failed to find the selected diet.

    
    var errorDescription: String {
        switch self {
        case .keychainUnhandledError(let status):
            return "Keychain unhandled error: \(status)"
        case .keychainItemNotFound:
            return "Keychain failed to find the target item"
        case .conversionFailed:
            return "Failed to convert variable"
        case .emptyEmailOrPassword:
            return "Email or password is empty"
        case .invalidEmailFormat:
            return "Invalid email format"
        case .invalidCredentials:
            return "Wrong email or password"
        case .emptyDataSource(let errorInfo):
            return "Required data \(errorInfo) is currently unavailable or empty"
        case .itemNotFound(let errorInfo):
            return "Failed to find the selected item: \(errorInfo)"
        }
    }
}
