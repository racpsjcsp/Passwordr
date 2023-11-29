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
            Label(K.Strings.homeNavTitle, systemImage: K.Strings.newspaper)
                .foregroundStyle(.myGreen)
        case .passwordGenerator:
            Label(K.Strings.passwordGenerator, systemImage: K.Strings.wandAndStars)
                .foregroundStyle(.myGreen)
        case .tipMe:
            Label(K.Strings.tipMe, systemImage: K.Strings.dollarsignCircle)
                .foregroundStyle(.myGreen)
        }
    }

    @ViewBuilder
    var destination: some View {
        switch self {
        case .credentials:
            CredentialsView()
        case .passwordGenerator:
            Text("Password Generator under construction!")
        case .tipMe:
            Text("Tip Me under construction!")
        }
    }
}
