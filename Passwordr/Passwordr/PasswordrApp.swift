//
//  PasswordrApp.swift
//  Passwordr
//
//  Created by Rafael Plinio on 14/11/23.
//

import SwiftUI
import SwiftData

@main
struct PasswordrApp: App {
    var body: some Scene {
        WindowGroup {
            PasswordrSplashView()
        }
        .modelContainer(for: [Credential.self])
    }
}
