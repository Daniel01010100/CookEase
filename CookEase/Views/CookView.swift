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
    @State private var recipeAmount: Int = 3    // Due to request limitation (only 50 times per day)
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                self.cevm.cookEaseThemeColour
                    .opacity(0.4)
                    .frame(height: 120)
                HStack {
                    Text("Cook")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.top, 60)
                }
                .padding(.horizontal)
            }
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                TextField("What recipe you want to search?", text: self.$queryText)
                    .autocapitalization(.none)
            }
            
            Picker("Recipe search quantity", selection: self.$recipeAmount) {
                ForEach(1...5, id: \.self) { amount in
                    Text("\(amount) Recipes")
                }
            }
            .padding()
            Button(action: {
                Task {
                    await self.cevm.generateRecipes(self.queryText, self.recipeAmount, false)
                }
            }, label: {
                Text("Search")
            })
            
            List(self.cevm.recommendRecipe, id: \.dishID) { recipe in
                RecipeListView(recipe: recipe, cevm: self.cevm)
            }
        }
    }
}

#Preview {
    CookView(cevm: CookEaseViewModel())
}
