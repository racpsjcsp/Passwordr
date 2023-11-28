//
//  PreviewContainer.swift
//  Passwordr
//
//  Created by Rafael Plinio on 28/11/23.
//

import Foundation
import SwiftData

struct PreviewContainer {
    let container: ModelContainer!

    init(_ types: [any PersistentModel.Type], isStoredInMemoryOnly: Bool = true) {
        let schema = Schema(types)
        let config = ModelConfiguration(isStoredInMemoryOnly: isStoredInMemoryOnly)
        do {
            self.container = try ModelContainer(for: schema, configurations: [config])
        } catch {
            fatalError("Failed to create container: \(error.localizedDescription)")
        }
    }

    func add(items: [any PersistentModel]) {
        Task { @MainActor in
            items.forEach { container.mainContext.insert($0) }
        }
    }
}
