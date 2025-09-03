//
//  ContentView.swift
//  CookEase
//
//  Created by YUDONG LU on 13/8/2025.
//

import SwiftUI

enum AuthRoute: Hashable {
    case signIn
    case signUp
    case resetPassword
}

struct ContentView: View {
    @Bindable var cevm: CookEaseViewModel
    var body: some View {
        if (cevm.isUserLoggedIn) {
            MainView(cevm:cevm)
        } else {
            NavigationStack(path: $cevm.navPath) {
                WelcomeView(cevm: cevm)
                    .navigationDestination(for: AuthRoute.self) { route in
                        switch route {
                        case .signIn:
                            SignInView(cevm: cevm)
                        case .signUp:
                            SignUpView(cevm: cevm)
                        case .resetPassword:
                            ResetPasswordView(cevm: cevm)
                        }
                    }
            }
        }
    }
}

#Preview {
    ContentView(cevm: CookEaseViewModel())
}
