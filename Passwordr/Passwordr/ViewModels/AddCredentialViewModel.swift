//
//  AddCredentialViewModel.swift
//  Passwordr
//
//  Created by Rafael Plinio on 25/11/23.
//

import Foundation
import SwiftData

class AddCredentialViewModel: ObservableObject {
    @Published var title: String = ""
    @Published var oldTitle: String = ""
    @Published var username: String = ""
    @Published var oldUsername: String = ""
    @Published var password: String = ""
    @Published var oldPassword: String = ""
    @Published var creationDate: String = ""
    @Published var lastChanged: String = ""

    var isFormComplete: Bool {
        if title.isEmpty || username.isEmpty || password.isEmpty {
            return false
        }

        if password.containsEmoji() {
            return false
        }
        
        return true
    }

    func updateLabelIfNeeded() {
        if !oldPassword.isEmpty && oldPassword != password {
            lastChanged = lastChanged.getCurrentDate()
        }
        
        if !oldPassword.isEmpty {
            lastChanged = lastChanged.getCurrentDate()
        }
    }
}
