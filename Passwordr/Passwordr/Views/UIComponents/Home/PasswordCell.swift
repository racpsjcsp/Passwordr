//
//  PasswordCell.swift
//  Passwordr
//
//  Created by Rafael Plinio on 18/11/23.
//

import SwiftUI

struct PasswordCell: View {
    let credential: Credential
    @Binding var password: String
    @State private var isSecureField: Bool = true
    private let pasteboard = UIPasteboard.general

    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Password", text: $password)
            } else {
                TextField(credential.password, text: $password)
            }
        }
        .overlay(alignment: .trailing) {
            Image(systemName: isSecureField ? "eye.slash" : "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
        .overlay(alignment: .leading) {
            Image(systemName: "doc.on.doc")
                .onTapGesture {
                    pasteboard.string = credential.password
                    if let string = pasteboard.string {
                        print("clipboard string: \(string)")
                    }
                }
                .offset(x: -30, y: 0)
        }
    }
}

#Preview {
    PasswordCell(credential: Credential(name: "abc", username: "def", password: "ghi"), password: .constant("password"))
}
