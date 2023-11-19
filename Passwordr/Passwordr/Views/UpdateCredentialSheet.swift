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
    
    var body: some View {
        NavigationStack {
            Form(content: {
                TextField("Name", text: $credential.name)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Login/Username", text: $credential.username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                TextField("Password", text: $credential.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
            })
            .navigationTitle("Edit Credential")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}
