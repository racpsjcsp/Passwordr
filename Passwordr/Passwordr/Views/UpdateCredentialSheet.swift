//
//  UpdateCredentialSheet.swift
//  Passwordr
//
//  Created by Rafael Plinio on 17/11/23.
//

import SwiftUI

struct UpdateCredentialSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var credential: Credential
    @State private var currentPassword = ""
    @State private var currentOldPassword = ""

    var body: some View {
        NavigationStack {
            Form {
                credentialFields
                oldPassword
                credentialInfo
            }
            .navigationTitle("Edit Credential")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save") {
                        if currentPassword != credential.password || currentOldPassword != credential.oldPassword {
                            credential.lastChanged = credential.getCurrentDate()
                        }

                        if credential.oldPassword != currentPassword {
                            credential.oldPassword = currentPassword
                        }

                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            currentPassword = credential.password
            currentOldPassword = credential.oldPassword
        }
    }
}


private extension UpdateCredentialSheet {
    var credentialFields: some View {
        Section {
            TextField("Name", text: $credential.name)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            TextField("Login/Username", text: $credential.username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            TextField("Password", text: $credential.password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        } header: {
            Text("Credential")
        } footer: {
            Text("Edit any field as needed")
        }
        .headerProminence(.increased)
    }

    var oldPassword: some View {
        Section {
            Text(credential.oldPassword)
                .disabled(true)
                .colorMultiply(.gray)
        } header: {
            Text("Old Password")
        }
        .headerProminence(.increased)
    }

    var credentialInfo: some View {
        Section {
            Text("Credential entry date: \($credential.creationDate.wrappedValue)")
            Text("Password last update: \($credential.lastChanged.wrappedValue)")
        } header: {
            Text("Information")
        }
        .headerProminence(.increased)
    }
}
