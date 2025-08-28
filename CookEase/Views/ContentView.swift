//
//  ContentView.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import SwiftUI

struct ContentView: View {
    var cevm: CookEaseViewModel
    var body: some View {
        if (cevm.isUserLoggedIn) {
            TabView {
                
            }
        } else {
            WelcomeView()
        }
    }
}

#Preview {
    ContentView()
}
