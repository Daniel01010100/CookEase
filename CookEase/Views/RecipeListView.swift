//
//  RecipeListView.swift
//  CookEase
//
//  Created by YUDONG LU on 6/9/2025.
//

import SwiftUI

struct RecipeListView: View {
    @Binding var isJumpToInstruction: Bool
    let recipe: Dish
    let cevm: CookEaseViewModel
    
    var body: some View {
        ZStack {
            HStack(spacing: 10) {
                if let imageURLStr = recipe.image,
                   let imageURL = URL(string: imageURLStr) {
                    AsyncImage(url: imageURL) { img in
                        img
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 120, height: 120)
                    .clipped()
                    .cornerRadius(10)
                    .padding(20)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.title ?? "No title specified")
                        .font(.subheadline)
                    if let mins = recipe.readyInMinutes {
                        Text("Ready in \(mins) mins")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .padding(20)
                    } else {
                        Text("No ready time specified")
                            .font(.body)
                            .foregroundStyle(.secondary)
                            .padding(20)
                    }
                    
                    Button(action: {
                        Task {
                            self.isJumpToInstruction = true
                            await self.cevm.fetchInstructionForRecipe(self.recipe.id)
                        }
                    }, label: {
                        Text("Get instruction")
                            .font(.subheadline)
                    })
                    .allowsHitTesting(true)
                    .buttonStyle(.plain)
                    .padding(10)
                    
                    HStack(spacing: 20) {
                        Button(action: {
                            let curPref = self.cevm.userVM.getUserDishPreference(recipe.dishID)
                            self.cevm.userVM.dishPreference = curPref == .favourite ? .none : .favourite
                            self.cevm.userVM.updateDishStatus(recipe.dishID, false)
                        }, label: {
                            Image(systemName: self.cevm.userVM.dishPreference == .favourite ? "heart.fill" : "heart")
                                .resizable()
                                .foregroundColor(self.cevm.userVM.dishPreference == .favourite ? .red : .secondary)
                                .frame(width: 20, height: 20)
                        })
                        .allowsHitTesting(true)
                        .buttonStyle(.plain)
                        
                        Button(action: {
                            let curPref = self.cevm.userVM.getUserDishPreference(recipe.dishID)
                            self.cevm.userVM.dishPreference = curPref == .dislike ? .none : .dislike
                            self.cevm.userVM.updateDishStatus(recipe.dishID, false)
                        }, label: {
                            Image(systemName: self.cevm.userVM.dishPreference == .dislike ? "heart.slash.fill" : "heart.slash")
                                .resizable()
                                .foregroundColor(self.cevm.userVM.dishPreference == .dislike ? .blue : .secondary)
                                .frame(width: 24, height: 24)
                        })
                        .allowsHitTesting(true)
                        .buttonStyle(.plain)
                    }
                }
            }
        }
    }
}
