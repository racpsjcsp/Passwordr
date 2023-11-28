//
//  CredentialsContainer.swift
//  Passwordr
//
//  Created by Rafael Plinio on 28/11/23.
//

import Foundation
import SwiftData

actor CredentialsContainer {
    @MainActor
    static func create(shouldCreateDefaults: inout Bool) -> ModelContainer {
        let schema = Schema([Credential.self])
        let config = ModelConfiguration()
        let container = try! ModelContainer(for: schema, configurations: [config])
        if shouldCreateDefaults {
            shouldCreateDefaults = false

            let credentials = DefaultsJSON.decode(from: "credential.json", type: [Credential].self)
            credentials?.forEach { container.mainContext.insert($0) }

            credentials?.forEach({ credential in
                container.mainContext.insert(credential)
            })
        }

        return container
    }
}
