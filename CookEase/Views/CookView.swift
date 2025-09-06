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
            
            List(self.cevm.recommendRecipe, id: \.id) { recipe in
                HStack {
                    if let imageURLStr = recipe.image,
                       let imageURL = URL(string: imageURLStr) {
                        AsyncImage(url: imageURL) { img in
                            img
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(width: 150, height: 150)
                        .clipped()
                        .cornerRadius(10)
                        .padding(20)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(recipe.title ?? "No title specified")
                            .font(.headline)
                        if let mins = recipe.readyInMinutes {
                            Text("Ready in \(mins) mins")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        } else {
                            Text("No ready time specified")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    CookView(cevm: CookEaseViewModel())
}
