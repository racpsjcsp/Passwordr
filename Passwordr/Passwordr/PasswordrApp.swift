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

//    let container: ModelContainer = {
//        let schema = Schema([Credential.self])
//        let container = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
//        .modelContainer(container)
        .modelContainer(for: [Credential.self])
    }
}
