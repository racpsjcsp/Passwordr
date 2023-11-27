//
//  CredentialsView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 25/11/23.
//

import SwiftUI
import SwiftData

struct CredentialsView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingCredentialSheet = false
    @Query(sort: \Credential.name) private var credentials: [Credential]
    @State private var credentialToEdit: Credential?

    var body: some View {
        NavigationStack {
            List {
                ForEach(credentials) { credential in
                    Section {
                        DisclosureGroup {
                            UsernameCell(credential: credential, username: .constant(credential.username))
                                .onEditTap(action: {
                                    credentialToEdit = credential
                                }, credential: Credential(name: credential.name,
                                                          oldName: credential.oldName,
                                                          username: credential.username,
                                                          oldUsername: credential.oldUsername,
                                                          password: credential.password,
                                                          oldPassword: credential.oldPassword,
                                                          creationDate: credential.creationDate,
                                                          lastChanged: credential.lastChanged))

                            PasswordCell(credential: credential, password: .constant(credential.password))
                        } label: {
                            HStack {
                                Text(credential.name)
                                Spacer()
                            }
                        }
                    }
                    .tint(Color(K.Strings.myGreen))
                    .listSectionSpacing(.custom(4))

                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        context.delete(credentials[index])
                    }
                })
            }
            .navigationTitle(K.Strings.homeNavTitle)
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isShowingCredentialSheet) { AddCredentialSheet() }
            .sheet(item: $credentialToEdit, content: { credential in
                UpdateCredentialSheet(credential: credential)
            })
            .toolbar {
                Button(K.Strings.homeAddCredentialTitle, systemImage: K.Strings.plus) {
                    isShowingCredentialSheet = true
                }
            }
            .tint(Color(K.Strings.myGreen))
        }
        .overlay {
            if credentials.isEmpty {
                ContentUnavailableView(label: {
                    Label(K.Strings.homeNoCredentialLabel, systemImage: K.Strings.newspaper)
                }, description: {
                    Text(K.Strings.homeCredentialDescription)
                }, actions: {
                    Button(K.Strings.homeAddCredentialTitle) {
                        isShowingCredentialSheet = true
                    }
                    .tint(Color(K.Strings.myGreen))
                })
            }
        }
    }
}
