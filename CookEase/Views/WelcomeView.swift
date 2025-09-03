//
//  WelcomeView.swift
//  CookEase
//
//  Created by YUDONG LU on 29/8/2025.
//

import SwiftUI

struct WelcomeView: View {
    enum WelcomeViewRoute: Hashable {
        case signIn
        case signUp
        case resetPassword
    }
    
    var cevm: CookEaseViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Text("Welcome to CookEase")
                    .font(.title)
                    .bold()
                    .foregroundColor(cevm.cookEaseThemeColour)
                    .frame(height: 100)
                
                Button(action: {
                    self.cevm.navPath.append(.signIn)
                }, label: {
                    Text("Sign In")
                        .bold()
                        .font(.title2)
                })
                .frame(height: 80)
                
                Text("Don't have an account?")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black)
                    .frame(height: 50)
                
                Button(action: {
                    self.cevm.navPath.append(.signUp)
                }, label: {
                    Text("Sign up")
                        .bold()
                        .font(.title2)
                })
            }
        }
    }
}

#Preview {
    WelcomeView(cevm: CookEaseViewModel())
}
