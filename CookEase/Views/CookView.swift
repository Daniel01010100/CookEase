//
//  CookView.swift
//  CookEase
//
//  Created by YUDONG LU on 3/9/2025.
//

import SwiftUI

struct CookView: View {
    @Bindable var cevm: CookEaseViewModel
    @State private var _queryText: String = ""
    @State private var _recipeAmount: Int = 3    // Due to request limitation (only 50 times per day)
    @State private var _isSuggestPersonalised: Bool = false
    @State var isJumpToInstruction: Bool = false
    
    var body: some View {
        NavigationStack {
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
                    TextField("What recipe you want to search?", text: self.$_queryText)
                        .autocapitalization(.none)
                }
                
                HStack(spacing: 10) {
                    Picker("Recipe search quantity", selection: self.$_recipeAmount) {
                        ForEach(1...5, id: \.self) { amount in
                            Text("\(amount) Recipes")
                        }
                    }
                    Toggle("Suggest personalised recipes", isOn: self.$_isSuggestPersonalised)
                }
                .padding()
                Button(action: {
                    Task {
                        await self.cevm.generateRecipes(self._queryText, self._recipeAmount, self._isSuggestPersonalised)
                    }
                }, label: {
                    Text("Search")
                })
                
                List(self.cevm.recommendRecipe, id: \.dishID) { recipe in
                    RecipeListView(isJumpToInstruction: self.$isJumpToInstruction, recipe: recipe, cevm: self.cevm)
                }
            }
            .navigationDestination(isPresented: self.$isJumpToInstruction) {
                CookingInstructionView(cevm: cevm)
            }
        }
    }
}

#Preview {
    CookView(cevm: CookEaseViewModel())
}
