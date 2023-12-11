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
    @ObservedObject private var viewModel = AddCredentialViewModel()

    var body: some View {
        NavigationStack {
            Form {
                TextField(K.Strings.title, text: $viewModel.title)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(!viewModel.title.isEmpty ? Color(
                        .myGreen) : Color(.myGray), lineWidth: 1))
                TextField(K.Strings.username, text: $viewModel.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(!viewModel.username.isEmpty ? Color(
                        .myGreen) : !viewModel.isFormComplete ? Color(.myGray) : Color(.myGreen), lineWidth: 1))
                TextField(K.Strings.password, text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(!viewModel.password.isEmpty ? Color(
                        .myGreen) : !viewModel.isFormComplete ? Color(.myGray) : Color(.myGreen), lineWidth: 1))
                TextField(K.Strings.oldPassword, text: $viewModel.oldPassword)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(.myGray), lineWidth: 1))

                Section(footer:
                            HStack {
                    Spacer()
                    Button(action: {
                        let credential = Credential(title: viewModel.title.capitalized,
                                                    oldTitle: viewModel.oldTitle,
                                                    username: viewModel.username,
                                                    oldUsername: viewModel.oldUsername,
                                                    password: viewModel.password,
                                                    oldPassword: viewModel.oldPassword,
                                                    creationDate: viewModel.creationDate,
                                                    lastChanged: viewModel.lastChanged)

                        viewModel.updateLabelIfNeeded()

                        credential.creationDate = credential.creationDate.getCurrentDate()

                        context.insert(credential)
                        dismiss()
                    }) {
                        Text(K.Strings.saveButton)
                            .padding()
                            .foregroundStyle(viewModel.isFormComplete ? Color(.myGreen) : Color(.myGray))
                    }
                    Spacer()
                }) {
                    EmptyView()
                }
                .disabled(!viewModel.isFormComplete)
                .buttonStyle(.bordered)
                .tint(viewModel.isFormComplete ? Color(.myGreen) : Color(.myGray))
            }

            .navigationTitle(K.Strings.addCredentialNavTitle)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button(K.Strings.cancelButton) {
                        dismiss()
                    }.foregroundStyle(.blue)
                }
            }
        }
    }
}

#Preview {
    AddCredentialSheet()
}
