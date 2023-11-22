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
                TextField("Name", text: $name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Login/Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Password", text: $password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Old Password (Optional)", text: $oldPassword)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()

            }
            .navigationTitle("New Credential")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        /// add string validations later...
                        let credential = Credential(name: name, username: username, password: password, oldPassword: oldPassword, creationDate: creationDate, lastChanged: lastChanged)

                        if !oldPassword.isEmpty && oldPassword != password {
                            credential.lastChanged = credential.getCurrentDate()
                        }

                        credential.creationDate = credential.getCurrentDate()

                        context.insert(credential)
                        dismiss()
                        /// save is automatic in swiftData, so the line below is not needed, just for learning purpose
//                        try! context.save()
                        /// try do catch block is necessary
                    }
                }
            }
        }
    }
}

#Preview {
    AddCredentialSheet()
}
