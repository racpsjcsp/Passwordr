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
    @State private var currentTitle = ""
    @State private var currentOldTitle = ""
    @State private var currentUsername = ""
    @State private var currentOldUsername = ""
    @State private var currentPassword = ""
    @State private var currentOldPassword = ""

    var body: some View {
        NavigationStack {
            Form {
                credentialFields
                oldCredential
                credentialInfo
            }
            .navigationTitle(K.Strings.updateCredentialNavTitle)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(K.Strings.cancelButton) {
                        restoreOldValues()
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(K.Strings.saveButton) {
                        updateOldCredentialsInfo()
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            storeCurrentCredential()
        }
    }
}

//MARK: - Store / Restore / Update of data for the UI

private extension UpdateCredentialSheet {
    private func storeCurrentCredential() {
        currentTitle = credential.title
        currentOldTitle = credential.oldTitle
        currentUsername = credential.username
        currentOldUsername = credential.oldUsername
        currentPassword = credential.password
        currentOldPassword = credential.oldPassword
    }

    private func restoreOldValues() {
        credential.title = currentTitle
        credential.username = currentUsername
        credential.password = currentPassword
    }

    private func updateOldCredentialsInfo() {
        if credential.oldTitle != currentTitle && credential.title != currentTitle {
            credential.oldTitle = currentTitle
            credential.lastChanged = credential.lastChanged.getCurrentDate()
        }

        if credential.oldUsername != currentUsername && credential.username != currentUsername {
            credential.oldUsername = currentUsername
            credential.lastChanged = credential.lastChanged.getCurrentDate()
        }

        if credential.oldPassword != currentPassword && credential.password != currentPassword {
            credential.oldPassword = currentPassword
            credential.lastChanged = credential.lastChanged.getCurrentDate()
        }
    }
}

//MARK: - UI

private extension UpdateCredentialSheet {
    var credentialFields: some View {
        Section {
            TextField(K.Strings.title, text: $credential.title)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            TextField(K.Strings.username, text: $credential.username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
            TextField(K.Strings.password, text: $credential.password)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        } header: {
            Text(K.Strings.updateCredentialHeader)
        } footer: {
            Text(K.Strings.updateCredentialFooter)
        }
        .headerProminence(.increased)
    }

    var oldCredential: some View {
        Section {
            Text(credential.oldTitle)
                .disabled(true)
                .colorMultiply(.gray)
            Text(credential.oldUsername)
                .disabled(true)
                .colorMultiply(.gray)
            Text(credential.oldPassword)
                .disabled(true)
                .colorMultiply(.gray)
        } header: {
            Text(K.Strings.updateOldCredential)
        }
        .headerProminence(.increased)
    }

    var credentialInfo: some View {
        Section {
            Text("\(K.Strings.updateCredentialInfoCreated) \($credential.creationDate.wrappedValue)")
            Text("\(K.Strings.updateCredentialInfoUpdated) \($credential.lastChanged.wrappedValue)")
        } header: {
            Text(K.Strings.updateCredentialInfoHeader)
        }
        .headerProminence(.increased)
    }
}
