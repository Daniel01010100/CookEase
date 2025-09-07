//
//  SettingView.swift
//  CookEase
//
//  Created by YUDONG LU on 3/9/2025.
//

import SwiftUI

struct SettingView: View {
    @Bindable var cevm: CookEaseViewModel
    @State private var activeSheet: ActiveSheet? = nil
    enum ActiveSheet: Identifiable, Hashable {
        case skill, tool, diet, dish, intolerance
        var id: Self { self }
    }
    
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
                    activeSheet = .skill
                }, label: {
                    Text("Cooking skill setting")
                        .font(.title2)
                })
                .padding(10)

                Button(action: {
                    activeSheet = .tool
                }, label: {
                    Text("Equipment setting")
                        .font(.title2)
                })
                .padding(10)

                Button(action: {
                    activeSheet = .diet
                }, label: {
                    Text("Diet setting")
                        .font(.title2)
                })
                .padding(10)

                Button(action: {
                    activeSheet = .dish
                }, label: {
                    Text("Dish preference setting")
                        .font(.title2)
                })
                .padding(10)

                Button(action: {
                    activeSheet = .intolerance
                }, label: {
                    Text("Intolerance setting")
                        .font(.title2)
                })
                .padding(10)
            }
            .listStyle(.plain)
            .padding(.top, -50)
        }
        .sheet(item: $activeSheet) { item in
            switch item {
            case .skill:
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
                        activeSheet = nil
                    }, label: {
                        Text("Save")
                    })
                }
            case .tool:
                // Placeholder for EquipmentSheetView
                VStack(alignment: .leading, spacing: 10) {
                    Text("What equipment do you have?")
                        .font(.title)
                        .bold()
                    ForEach(CommonEquipment.allCases, id:\.self) { device in
                        Button(action: {
                            if (self.cevm.userVM.getUserOwnedEquipment().contains(device)) {
                                do {
                                    try self.cevm.userVM.deleteOwnedEquipment(device)
                                } catch {
                                    print("Error occurred while deleting equipment: \(error)")
                                }
                            } else {
                                self.cevm.userVM.addOwnedquipment(device)
                            }
                        }, label: {
                            Text(device.rawValue)
                                .font(.caption)
                                .foregroundColor(self.cevm.userVM.getUserOwnedEquipment().contains(device) ? .blue : .secondary)
                        })
                    }
                    .padding(8)
                    
                    Button("Save") { activeSheet = nil }
                }
            case .diet:
                // Placeholder for DietSheetView
                VStack(alignment: .leading, spacing: 10) {
                    Text("What diet do you follow?")
                        .font(.title)
                        .bold()
                    ForEach(Diet.allCases, id:\.self) { diet in
                        Button(action: {
                            if (self.cevm.userVM.getUserDietaryPreferences().contains(diet)) {
                                do {
                                    try cevm.userVM.deleteDietaryPreference(diet)
                                } catch {
                                    print("Error occurred while deleting diet: \(error)")
                                }
                            } else {
                                self.cevm.userVM.addDietaryPreference(diet)
                            }
                        }, label: {
                            Text(diet.rawValue)
                                .font(.caption)
                                .foregroundColor(self.cevm.userVM.getUserDietaryPreferences().contains(diet) ? .blue : .secondary)
                        })
                        .padding(8)
                    }
                    Button("Save") { activeSheet = nil }
                }
            case .dish:
                // Placeholder for DishPreferenceSheetView
                VStack(alignment: .center, spacing: 10) {
                    Text("Dish Preference Sheet View")
                        .font(.title)
                        .bold()
                    
                    Button("Save") { activeSheet = nil }
                }
            case .intolerance:
                // Placeholder for IntoleranceSheetView
                VStack(alignment: .leading, spacing: 10) {
                    Text("What's your intolerances?")
                        .font(.title)
                        .bold()
                    ForEach(Intolerance.allCases, id: \.self) { intolerance in
                        Button(action: {
                            if (self.cevm.userVM.getUserIntolerances().contains(intolerance)) {
                                do {
                                    try self.cevm.userVM.deleteIntolerance(intolerance)
                                } catch {
                                    print("Error occurred while deleting intolerance: \(error)")
                                }
                            } else {
                                self.cevm.userVM.addIntolerance(intolerance)
                            }
                        }, label: {
                            Text(intolerance.rawValue)
                                .font(.caption)
                                .foregroundColor(self.cevm.userVM.getUserIntolerances().contains(intolerance) ? .blue : .secondary)
                        })
                    }
                    .padding(8)
                    
                    Button("Save") { activeSheet = nil }
                }
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
