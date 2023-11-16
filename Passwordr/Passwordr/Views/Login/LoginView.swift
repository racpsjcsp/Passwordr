//
//  LoginView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
        @EnvironmentObject var authenticationManager: AuthenticationManager
        
        VStack(spacing: 40) {
            LoginTitle()
            
            // Evaluate the biometryType and display a button accordingly
            switch AuthenticationManager().biometryType {
            case .faceID:
                LoginButton(image: "faceid", text: "Login with FaceID")
                    .onTapGesture {
                        Task.init {
                            await AuthenticationManager().authenticateWithBiometrics()
                        }
                    }
            default:
                LoginButton(image: "touchid", text: "Login with TouchID")
                    .onTapGesture {
                        Task.init {
                            await AuthenticationManager().authenticateWithBiometrics()
                        }
                    }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple],
                                   startPoint: .topLeading, endPoint: .bottomTrailing))
    }
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationManager())
    }
}
