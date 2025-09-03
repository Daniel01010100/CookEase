//
//  SettingView.swift
//  CookEase
//
//  Created by YUDONG LU on 3/9/2025.
//

import SwiftUI

struct SettingView: View {
    @Bindable var cevm: CookEaseViewModel
    @State private var showSkillSheet = false
    @State private var showEquipmentSheet = false
    @State private var showDietSheet = false
    @State private var showCuisineSheet = false
    @State private var showIntoleranceSheet = false
    
    var body: some View {
        NavigationStack {
            List {
                Button(action: {
                    self.showSkillSheet.toggle()
                }, label: {
                    Text("Cooking skill lvel")
                })
            }
        }
    }
}

#Preview {
    SettingView(cevm: CookEaseViewModel())
}
