//
//  CookEaseApp.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import SwiftUI

@main
struct CookEaseApp: App {
    var cevm: CookEaseViewModel = CookEaseViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(cevm: cevm)
        }
    }
}
