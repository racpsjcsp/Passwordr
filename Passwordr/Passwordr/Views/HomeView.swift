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
    private let rainbowColors: [Color] = [.red, .orange, .yellow, .green, .blue, .indigo, .purple]

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
                        .tint(Color("myGreen"))
                        .listSectionSpacing(.custom(4))

                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            context.delete(credentials[index])
                        }
                    })
                }
                .navigationTitle("Credentials")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $isShowingCredentialSheet) { AddCredentialSheet() }
                .sheet(item: $credentialToEdit, content: { credential in
                    UpdateCredentialSheet(credential: credential)
                })
                .toolbar {
                    Button("Add Credential", systemImage: "plus") {
                        isShowingCredentialSheet = true
                    }
                }
                .tint(Color("myGreen"))
            }
            .overlay {
                if credentials.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Credentials", systemImage: "newspaper")
                    }, description: {
                        Text("Add a new credential to start")
                    }, actions: {
                        Button("Add Credential") {
                            isShowingCredentialSheet = true
                        }
                        .tint(Color("myGreen"))
                    })
                }
            }
        } else {
            VStack(spacing: 40) {
                FaceIDTitle()

                FaceIDButton(image: "faceid", text: "Login with FaceID")
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
