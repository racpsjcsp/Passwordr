//
//  HomeView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel = HomeViewViewModel()
    @Environment(\.modelContext) var context
    @State private var isShowingCredentialSheet = false
    @Query(sort: \Credential.name) private var credentials: [Credential]
    @State private var credentialToEdit: Credential?

    var body: some View {
        if viewModel.isAuthenticated {
            NavigationStack {
                List {
                    ForEach(credentials) { credential in
                        Section {
                            DisclosureGroup {
                                UsernameCell(credential: credential, username: .constant(credential.username))
                                    .onEditTap(action: {
                                        credentialToEdit = credential
                                    }, credential: Credential(name: credential.name,
                                                              username: credential.username,
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
        } else {
            VStack(spacing: 40) {
                FaceIDTitle()

                FaceIDButton(image: K.Strings.faceID, text: K.Strings.authScreenTitle)
                    .onTapGesture {
                        Task {
                            await viewModel.authenticateWithFaceID()
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
