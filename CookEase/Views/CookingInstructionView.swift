//
//  CookingInstructionView.swift
//  CookEase
//
//  Created by YUDONG LU on 7/9/2025.
//

import SwiftUI

struct CookingInstructionView: View {
    var cevm: CookEaseViewModel
    
    var body: some View {
        let steps = self.cevm.recipeInstruction.steps
        if (steps.isEmpty) {
            Text("No instruction available.")
                .font(.headline)
                .foregroundColor(.secondary)
        } else {
            List(steps, id: \.id) { step in
                VStack(alignment: .center) {
                    Text("Step \(step.number)")
                        .font(.headline)
                    Text(step.step ?? "")
                        .font(.subheadline)
                    if let ingredients = step.ingredients, !ingredients.isEmpty {
                        VStack(alignment: .leading) {
                            Text("Ingredients needed: ")
                                .font(.body)
                            ForEach(ingredients, id:\.ingredientID) { ingredient in
                                HStack {
                                    Text(ingredient.name ?? "Unnamed ingredient")
                                        .font(.body)
                                    if let amount = ingredient.amount, amount > 0.0 {
                                        Text(String(format: "%.1f", amount))
                                            .font(.body)
                                    }
                                    if let unit = ingredient.unit, !unit.isEmpty {
                                        Text(unit)
                                            .font(.body)
                                    }
                                }
                            }
                        }
                    } else {
                        Text("No ingredient list available.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    
                    if let tools = step.equipment, !tools.isEmpty {
                        
                    } else {
                        Text("No equipment list available.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

#Preview {
    CookingInstructionView(cevm: CookEaseViewModel())
}
