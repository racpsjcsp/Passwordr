//
//  AddCredentialSheet.swift
//  Passwordr
//
//  Created by Rafael Plinio on 17/11/23.
//

import SwiftUI

struct AddCredentialSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var oldPassword: String = ""
    @State private var creationDate: String = ""
    @State private var lastChanged: String = ""


    var body: some View {
        NavigationStack {
            Form {
                TextField(K.Strings.name, text: $name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField(K.Strings.username, text: $username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField(K.Strings.password, text: $password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField(K.Strings.oldPassword, text: $oldPassword)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

            }
            .navigationTitle(K.Strings.addCredentialNavTitle)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(K.Strings.cancelButton) { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(K.Strings.saveButton) {
                        /// add string validations later...
                        let credential = Credential(name: name, username: username, password: password, oldPassword: oldPassword, creationDate: creationDate, lastChanged: lastChanged)

                        if !oldPassword.isEmpty && oldPassword != password {
                            credential.lastChanged = credential.getCurrentDate()
                        }

                        credential.creationDate = credential.getCurrentDate()

                        context.insert(credential)
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    AddCredentialSheet()
}
