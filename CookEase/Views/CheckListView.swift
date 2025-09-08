//
//  CheckListView.swift
//  CookEase
//
//  Created by YUDONG LU on 3/9/2025.
//

import SwiftUI

struct CheckListView: View {
    @Bindable var cevm: CookEaseViewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            List(self.cevm.userVM.getUserExistingIngredients(), id: \.id) { ingredient in
                Text(ingredient.name ?? "")
            }
        }
    }
    
}

#Preview {
    CheckListView(cevm: CookEaseViewModel())
}
