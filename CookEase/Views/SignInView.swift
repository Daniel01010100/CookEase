//
//  SignInView.swift
//  CookEase
//
//  Created by YUDONG LU on 29/8/2025.
//

import SwiftUI

struct SignInView: View {
    var cevm: CookEaseViewModel
    @State var loginEmail: String = ""
    @State var loginPassword: String = ""
    @State var loginStatus: Bool = false
    @State private var _isLoginFailed: Bool = false
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text("CookEase")
                .padding(.top)
                .font(.title)
                .foregroundColor(cevm.cookEaseThemeColour)
                .bold()
                .frame(height: 300)
            
            HStack {
                Text("Email: ")
                    .font(.title2)
                Spacer()
                TextField("Your email address ", text: self.$loginEmail)
            }
            .frame(height: 40)
            
            HStack {
                Text("Password: ")
                    .font(.title2)
                Spacer()
                TextField("**********", text: self.$loginPassword)
            }
            .frame(height: 40)
            
            Button(action: {
                self.cevm.navPath.append(.resetPassword)
            }, label: {
                Text("Forgot Password?")
                    .foregroundColor(cevm.cookEaseThemeColour)
                    .bold()
                    .frame(height: 100)
            })
            
            Button(action:{
                self.loginStatus = self.cevm.userVM.signIn(self.loginEmail, self.loginPassword)
                if (self.loginStatus) {
                    self.cevm.userVM.userProfile.isLogin = true
                } else {
                    self._isLoginFailed = true
                }
            }, label: {
                Text("Sign In")
                    .bold()
            })
            Spacer()
        }
        .alert("Login Failed", isPresented: self.$_isLoginFailed) {
            Button("Confirm", role: .cancel) { }
        } message: {
            Text("Invalid email or password. Please try again.")
        }
    }
}

#Preview {
    SignInView(cevm: CookEaseViewModel())
}
