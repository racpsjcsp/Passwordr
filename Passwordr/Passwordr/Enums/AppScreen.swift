//
//  AppScreen.swift
//  Passwordr
//
//  Created by Rafael Plinio on 29/11/23.
//

import SwiftUI

enum AppScreen: Hashable, Identifiable, CaseIterable {
    case credentials
    case passwordGenerator
    case tipMe

    var id: AppScreen { self }
}

extension AppScreen {
    @ViewBuilder
    var label: some View {
        switch self {
        case .credentials:
            Label(K.Strings.homeNavTitle, systemImage: K.Image.newspaper)
        case .passwordGenerator:
            Label(K.Strings.passwordGenerator, systemImage: K.Image.wandAndStars)
        case .tipMe:
            Label(K.Strings.tipMe, systemImage: K.Image.dollarsignCircle)
        }
    }

    @ViewBuilder
    var destination: some View {
        VStack {
            switch self {
            case .credentials:
                CredentialsView()
            case .passwordGenerator:
                PasswordGeneratorView()
            case .tipMe:
                TipView()
            }
        }
    }
}
