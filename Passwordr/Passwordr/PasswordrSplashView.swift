//
//  PasswordrSplashView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 20/11/23.
//

import SwiftUI

struct PasswordrSplashView: View {
    @State var isActive: Bool = false

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            if isActive {
                HomeView()
            } else {
                Image(K.Image.passwordrLogo)
                    .resizable()
                    .scaledToFit()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    PasswordrSplashView()
}
