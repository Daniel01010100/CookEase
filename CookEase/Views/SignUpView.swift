//
//  SignUpView.swift
//  CookEase
//
//  Created by YUDONG LU on 29/8/2025.
//

import SwiftUI

struct SignUpView: View {
    var cevm: CookEaseViewModel
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var securityQuestion: String = ""
    @State var securityAnswer: String = ""
    @State private var _isSignUpSuccess: Bool = false
    @State private var _isCredentialError: Bool = false
    
    var body: some View {
        Text("CookEase")
            .padding(.top)
            .font(.title)
            .foregroundColor(cevm.cookEaseThemeColour)
            .bold()
            .frame(height: 200)
        
        VStack(spacing: 10) {
            HStack {
                Text("Email: ")
                TextField("Your email address", text: self.$email)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(15)
            
            HStack {
                Text("Password: ")
                TextField("Your password", text: self.$password)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(15)
            
            HStack {
                Text("Confirm Password: ")
                TextField("Your password", text: self.$confirmPassword)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(15)
            
            HStack {
                Text("Security Question")
                TextField("Your question", text: self.$securityQuestion)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(15)
            
            HStack {
                Text("Security Answer")
                TextField("Your answer", text: self.$securityAnswer)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(15)
            
            
            Button(action: {
                self.register()
            }, label: {
                Text("Sign Up")
                    .bold()
            })
            .frame(height: 100)
        }
        .alert("Wrong Credentials", isPresented: self.$_isCredentialError) {
            Button("Confirm", role: .cancel) {}
        } message: {
            Text("Empty fields or incorrect credentials. Please try again.")
        }
        .alert("You have signed up successfully", isPresented: self.$_isSignUpSuccess) {
            Button("OK", role:.cancel) {}
        }
    }
    
    func register() {
        if (self.password != self.confirmPassword) {
            self._isCredentialError = true
            return
        }
        self._isSignUpSuccess = cevm.userVM.signUp(email, password, securityQuestion, securityAnswer)
        self._isCredentialError = !self._isSignUpSuccess
    }
}

#Preview {
    SignUpView(cevm: CookEaseViewModel())
}
