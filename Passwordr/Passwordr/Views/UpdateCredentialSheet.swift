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
            .navigationTitle(K.Strings.updateCredentialNavTitle)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(K.Strings.cancelButton) {
                        dismiss()
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button(K.Strings.saveButton) {
                        if credential.oldPassword != currentPassword && credential.password != currentPassword {
                            credential.oldPassword = currentPassword
                            credential.lastChanged = credential.lastChanged.getCurrentDate()
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
            TextField(K.Strings.name, text: $credential.name)
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

    var oldPassword: some View {
        Section {
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
