//
//  UsernameCell.swift
//  Passwordr
//
//  Created by Rafael Plinio on 18/11/23.
//

import SwiftUI

struct UsernameCell: View {
    let credential: Credential
    var onEditTap: (() -> Void)?
    @Binding var username: String
    @State private var credentialToEdit: Credential?
    private let pasteboard = UIPasteboard.general
    @State private var copied = false {
        didSet {
            if copied {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        copied = false
                    }
                }
            }
        }
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                HStack {
                    TextField(credential.username, text: $username)
                        .disabled(true)
                    Spacer()
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: K.Strings.pencil)
                        .onTapGesture {
                            onEditTap?()
                        }
                        .offset(x: 16, y: 0)
                        .foregroundStyle(Color(K.Strings.myGreen))
                }
                .overlay(alignment: .leading) {
                    Image(systemName: K.Strings.docOndoc)
                        .onTapGesture {
                            pasteboard.string = credential.username
                            
                            withAnimation {
                                copied = true
                            }
                        }
                        .offset(x: -36, y: 0)
                        .foregroundStyle(Color(K.Strings.myGreen))
                }
                
                if copied {
                    ToastView(toastMessage: K.Strings.clipboardMessage, copied: copied)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

extension UsernameCell {
    func onEditTap(action: @escaping (() -> Void), credential: Credential) -> UsernameCell {
        UsernameCell(credential: Credential(title: "name", oldTitle: "oldName", username: "username", oldUsername: "oldUsername", password: "password", oldPassword: "old password (optional)", creationDate: "10/10/1985", lastChanged: "10/10/2023"), onEditTap: action, username: .constant(username))
    }
}
