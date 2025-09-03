//
//  CookView.swift
//  CookEase
//
//  Created by YUDONG LU on 3/9/2025.
//

import SwiftUI

struct CookView: View {
    @Bindable var cevm: CookEaseViewModel
    @State private var queryText: String = ""
    @State private var searchResults: [Dish] = []
    
    var body: some View {
        TextField("Recipe you want to search", text: self.$queryText)
        
    }
}

#Preview {
    CookView(cevm: CookEaseViewModel())
}
