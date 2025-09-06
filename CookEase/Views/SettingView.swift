//
//  SettingView.swift
//  CookEase
//
//  Created by YUDONG LU on 3/9/2025.
//

import SwiftUI

struct SettingView: View {
    @Bindable var cevm: CookEaseViewModel
    @State private var _showSkillSheet = false
    @State private var _showEquipmentSheet = false
    @State private var _showDietSheet = false
    @State private var _showDishSheet = false
    @State private var _showIntoleranceSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                self.cevm.cookEaseThemeColour
                    .opacity(0.4)
                    .frame(height: 120)
                    .edgesIgnoringSafeArea(.all)
                HStack {
                    Text("Setting")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.top, -50)
                }
                .padding(.horizontal)
            }
            
            List {
                Button(action: {
                    self._showSkillSheet.toggle()
                }, label: {
                    Text("Cooking skill setting")
                        .font(.title2)
                })
                .padding(10)
                
                Button(action: {
                    self._showEquipmentSheet.toggle()
                }, label: {
                    Text("Equipment setting")
                        .font(.title2)
                })
                .padding(10)
                
                Button(action: {
                    self._showDietSheet.toggle()
                }, label: {
                    Text("Diet setting")
                        .font(.title2)
                })
                .padding(10)
                
                Button(action: {
                    self._showDishSheet.toggle()
                }, label: {
                    Text("Dish preference setting")
                        .font(.title2)
                })
                .padding(10)
                
                Button(action: {
                    self._showIntoleranceSheet.toggle()
                }, label: {
                    Text("Intolerance setting")
                        .font(.title2)
                })
                .padding(10)
            }
            .listStyle(.plain)
            .padding(.top, -50)
        }
        .sheet(isPresented: self.$_showSkillSheet) {
            VStack(spacing: 24) {
                Text("What's your cooking level?")
                    .font(.title)
                    .bold()
                
                // HStack of skill buttons. Hightlight selected and lower skill level icons.
                HStack(spacing: 32) {
                    ForEach(0..<3) { idx in
                        Button(action: {
                            cevm.userVM.setCookingSkill(idx)
                        }, label: {
                            Image(systemName: "fork.knife.circle")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(idx <= cevm.userVM.getUserCookingSkill().rawValue ? self.cevm.cookEaseThemeColour : .secondary)
                        })
                    }
                }
                
                VStack(spacing: 8) {
                    // Name for selected skill level.
                    Text(getCookingSkillName(cevm.userVM.getUserCookingSkill().rawValue))
                        .font(.headline)
                    // Description for selected skill level.
                    Text(getCookingSKillDescription(cevm.userVM.getUserCookingSkill().rawValue))
                        .font(.subheadline)
                        .padding(.horizontal)
                }
                Button(action: {
                    self._showSkillSheet = false
                }, label: {
                    Text("Save")
                })
            }
        }
    }
    
    private func getCookingSkillName(_ skill: Int) -> String {
        switch skill {
        case 0:
            return "Beginner"
        case 1:
            return "Intermediate"
        case 2:
            return "Advanced"
        default:
            return "Unknown"
        }
    }
    
    private func getCookingSKillDescription(_ skill: Int) -> String {
        switch skill {
        case 0:
            return "I can flollow basic recipes and make simple dishes."
        case 1:
            return "I can cook a variety of dishes without much help."
        case 2:
            return "I can create complex dishes on my own."
        default:
            return "Unknown"
        }
    }
}

#Preview {
    SettingView(cevm: CookEaseViewModel())
}
