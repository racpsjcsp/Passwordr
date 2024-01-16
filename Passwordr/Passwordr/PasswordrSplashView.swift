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
                Image(systemName: K.Image.lockShieldLogo)
                    .resizable()
                    .frame(width: 280, height: 250)
                    .foregroundStyle(.myBlue)
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
