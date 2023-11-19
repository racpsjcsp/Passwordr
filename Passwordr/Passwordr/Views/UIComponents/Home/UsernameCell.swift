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
    @State private var credentialToEdit: Credential?
    private let pasteboard = UIPasteboard.general
    
    var body: some View {
        HStack {
            Text(credential.username)
            Spacer()
            
        }
        .overlay(alignment: .trailing) {
            Image(systemName: "pencil")
                .onTapGesture {
                    onEditTap?()
                }
        }
        .overlay(alignment: .leading) {
            Image(systemName: "doc.on.doc")
                .onTapGesture {
                    pasteboard.string = credential.username
                    if let string = pasteboard.string {
                        print("clipboard string: \(string)")
                    }
                }
                .offset(x: -30, y: 0)
        }
    }
}

#Preview {
    UsernameCell(credential: Credential(name: "abc", username: "def", password: "ghi"))
}

extension UsernameCell {
    func onEditTap(action: @escaping (() -> Void), credential: Credential) -> UsernameCell {
        UsernameCell(credential: Credential(name: credential.name, username: credential.username, password: credential.password), onEditTap: action)
        }
}

