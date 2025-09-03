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
    @State private var isSignUpSuccess: Bool = false
    
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
            }
            .padding(15)
            
            HStack {
                Text("Password: ")
                TextField("Your password", text: self.$password)
            }
            .padding(15)
            
            HStack {
                Text("Confirm Password: ")
                TextField("Your password", text: self.$confirmPassword)
            }
            .padding(15)
            
            HStack {
                Text("Security Question")
                TextField("Your question", text: self.$securityQuestion)
            }
            .padding(15)
            
            HStack {
                Text("Security Answer")
                TextField("Your answer", text: self.$securityAnswer)
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
        .alert("Wrong Credentials", isPresented: self.$isSignUpSuccess) {
            Button("Confirm", role: .cancel) { }
        } message: {
            Text("Empty fields or incorrect credentials. Please try again.")
        }
    }
    
    func register() {
        if (self.password != self.confirmPassword) {
            self.isSignUpSuccess = false
            return
        }
        self.isSignUpSuccess = cevm.userVM.signUp(email, password, securityQuestion, securityAnswer)
    }
}

#Preview {
    SignUpView(cevm: CookEaseViewModel())
}
