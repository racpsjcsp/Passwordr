//
//  AddCredentialViewModel.swift
//  Passwordr
//
//  Created by Rafael Plinio on 25/11/23.
//

import Foundation
import SwiftData

class AddCredentialViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var oldPassword: String = ""
    @Published var creationDate: String = ""
    @Published var lastChanged: String = ""

    func updateLabelIfNeeded() {
        if !oldPassword.isEmpty && oldPassword != password {
            lastChanged = lastChanged.getCurrentDate()
        }
        
        if !oldPassword.isEmpty {
            lastChanged = lastChanged.getCurrentDate()
        }
    }
}
