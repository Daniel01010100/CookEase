//
//  CookEaseError.swift
//  CookEase
//
//  Created by YUDONG LU on 25/8/2025.
//

import Foundation

enum CookEaseError: Error {
    case emptyDataSource(errorInfo: String)    // Target data is empty
    case itemNotFound(errorInfo: String)   // Failed to find the selected diet.
    case duplicateItem(errorInfo: String)   // Add the same item repeatedly.
    case conversionFailed   // Failed to convert variable.
    case invalidURL(errorInfo: String)     // Error occurs when trying to unwrap url.
    case saveDataFailed(errorInfo: String)
    case loadDataFailed(errorInfo: String)
    case jsonCodingFailed(errorInfo: String)    // Failed to encode data.
    case jsonDecodingFailed(errorInfo: String)  // Failed to decode data.

    
    var errorDescription: String {
        switch self {            
        case .emptyDataSource(let errorInfo):
            return "Required data \(errorInfo) is currently unavailable or empty"
        case .itemNotFound(let errorInfo):
            return "Failed to find the selected item: \(errorInfo)"
        case .duplicateItem(let errorInfo):
            return "Should not add same item repeatedly: \(errorInfo)"
        case .conversionFailed:
            return "Failed to convert variable"
            
        case .invalidURL(let errorInfo):
            return "Invalid URL: \(errorInfo)"
        case .saveDataFailed(let errorInfo):
            return "Failed to save data: \(errorInfo)"
        case .loadDataFailed(errorInfo: let errorInfo):
            return "Failed to load data: \(errorInfo)"
            
        case .jsonCodingFailed(let errorInfo):
            return "Failed to encode data: \(errorInfo)"
        case .jsonDecodingFailed(let errorInfo):
            return "Failed to decode data: \(errorInfo)"
        }
    }
}
