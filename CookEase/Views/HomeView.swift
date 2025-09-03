//
//  HomeView.swift
//  CookEase
//
//  Created by YUDONG LU on 30/8/2025.
//

import SwiftUI

struct HomeView: View {
    @Bindable var cevm: CookEaseViewModel
    
    var body: some View {
        Text("Hello, World!")
    }
    
}

#Preview {
    HomeView(cevm: CookEaseViewModel())
}
