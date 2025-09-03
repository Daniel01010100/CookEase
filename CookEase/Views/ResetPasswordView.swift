//
//  ResetPasswordView.swift
//  CookEase
//
//  Created by YUDONG LU on 30/8/2025.
//

import SwiftUI

struct ResetPasswordView: View {
    @Bindable var cevm: CookEaseViewModel
    @State var answer: String = ""
    
    var body: some View {
        VStack {
            Text(self.cevm.userVM.getUserSecurityQuestion())
        }
        
    }
}

#Preview {
    ResetPasswordView(cevm: CookEaseViewModel())
}
