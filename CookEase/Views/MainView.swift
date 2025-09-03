//
//  MainView.swift
//  CookEase
//
//  Created by YUDONG LU on 3/9/2025.
//

import SwiftUI

struct MainView: View {
    var cevm: CookEaseViewModel
    @State private var defaultTab = 2   // 0 - CheckList, 1 - Cook, 2 - Home, 3 - Setting.
    var body: some View {
        TabView(selection: self.$defaultTab) {
            CheckListView(cevm: cevm)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("CheckList")
                }
                .tag(0)
            CookView(cevm: cevm)
                .tabItem {
                    Image(systemName: "frying.pan")
                    Text("Cook")
                }
                .tag(1)
            HomeView(cevm: cevm)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
                .tag(2)
            
            SettingView(cevm: cevm)
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
                .tag(3)
        }
    }
}

#Preview {
    MainView(cevm: CookEaseViewModel())
}
