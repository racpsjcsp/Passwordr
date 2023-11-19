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
                        DisclosureGroup {
                            UsernameCell(credential: credential)
                                .onEditTap(action: {
                                    credentialToEdit = credential
                                }, credential: Credential(name: credential.name, username: credential.username, password: credential.password))
                            PasswordCell(credential: credential, password: .constant(credential.password))
                        } label: {
                            HStack {
                                Text(credential.name)
                                Spacer()
                            }
                        }

                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            context.delete(credentials[index])
                        }
                    })
                }
                .navigationTitle("Credentials")
                .navigationBarTitleDisplayMode(.inline)
                .listRowSeparator(.visible)
                .sheet(isPresented: $isShowingCredentialSheet) { AddCredentialSheet() }
                .sheet(item: $credentialToEdit, content: { credential in
                    UpdateCredentialSheet(credential: credential)
                })
                .toolbar {
                        Button("Add Credential", systemImage: "plus") {
                            isShowingCredentialSheet = true
                        }
                }
            }
            .overlay {
                if credentials.isEmpty {
                    ContentUnavailableView(label: {
                        Label("No Credentials", systemImage: "newspaper")
                    }, description: {
                        Text("Add a new credential to start")
                    }, actions: {
                        Button("Add Credential") { isShowingCredentialSheet = true }
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
            .background(LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple],
                                       startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
