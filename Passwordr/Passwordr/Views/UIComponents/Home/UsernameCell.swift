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
    private let pasteboard = UIPasteboard.general
    @Binding var username: String
    @State private var credentialToEdit: Credential?
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
                        .font(username.count > 25 ? .system(size: 15) : .body)
                        .disabled(true)
                    Spacer()
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: K.Image.sliderHorizontalMenu)
                        .onTapGesture {
                            onEditTap?()
                        }
                        .offset(x: 4, y: 0)
                        .foregroundStyle(Color(.myGreen))
                }
                .overlay(alignment: .leading) {
                    Image(systemName: K.Image.docOndoc)
                        .onTapGesture {
                            pasteboard.string = $username.wrappedValue

                            withAnimation {
                                copied = true
                            }
                        }
                        .offset(x: -30, y: 0)
                        .foregroundStyle(Color(.myGreen))
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
