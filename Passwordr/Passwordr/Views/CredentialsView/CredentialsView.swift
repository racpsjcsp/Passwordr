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
    @Query(sort: \Credential.title) private var credentials: [Credential]
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
                                }, credential: Credential(title: credential.title,
                                                          oldTitle: credential.oldTitle,
                                                          username: credential.username,
                                                          oldUsername: credential.oldUsername,
                                                          password: credential.password,
                                                          oldPassword: credential.oldPassword,
                                                          creationDate: credential.creationDate,
                                                          lastChanged: credential.lastChanged))

                            PasswordCell(credential: credential, password: .constant(credential.password))
                        } label: {
                            CredentialItem(credential: credential)
                        }
                    }
                    .listSectionSpacing(.custom(8))
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
                Button(K.Strings.homeAddCredentialTitle, systemImage: K.Image.plus) {
                    isShowingCredentialSheet = true
                }
            }
            .tint(Color(.myGreen))
        }
        .overlay {
            if credentials.isEmpty {
                ContentUnavailableView(label: {
                    Label(K.Strings.homeNoCredentialLabel, systemImage: K.Image.newspaper)
                }, description: {
                    Text(K.Strings.homeCredentialDescription)
                }, actions: {
                    Button(K.Strings.homeAddCredentialTitle) {
                        isShowingCredentialSheet = true
                    }
                    .tint(Color(.myGreen))
                })
            }
        }
    }
}

#Preview(K.Strings.credentialScreenEmpty) {
    let preview = PreviewContainer([Credential.self])
    return CredentialsView().modelContainer(preview.container)
}

#Preview(K.Strings.credentialScreen){
    let preview = PreviewContainer([Credential.self])
    if let credentials = DefaultsJSON.decode(from: "credential", type: [Credential].self) {
        preview.add(items: credentials)
    }
    return CredentialsView().modelContainer(preview.container)
}
