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
    @StateObject private var viewModel = AddCredentialViewModel()

    var body: some View {
        NavigationStack {
            Form {
                TextField(K.Strings.name, text: $viewModel.name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField(K.Strings.username, text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField(K.Strings.password, text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField(K.Strings.oldPassword, text: $viewModel.oldPassword)
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
                        let credential = Credential(name: viewModel.name.capitalized,
                                                    username: viewModel.username,
                                                    password: viewModel.password,
                                                    oldPassword: viewModel.oldPassword,
                                                    creationDate: viewModel.creationDate,
                                                    lastChanged: viewModel.lastChanged)

                        viewModel.updateLabelIfNeeded()

                        credential.creationDate = credential.creationDate.getCurrentDate()

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
