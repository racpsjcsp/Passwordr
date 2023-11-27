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
                    if isSecureField {
                        SecureField(K.Strings.password, text: $password)
                            .disabled(true)
                    } else {
                        TextField(credential.password, text: $password)
                            .disabled(true)
                    }
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: isSecureField ? K.Strings.eye : K.Strings.eyeSlash)
                        .onTapGesture {
                            isSecureField.toggle()
                        }
                        .offset(x: 16, y: 0)
                        .foregroundStyle(Color(K.Strings.myGreen))
                }
                .overlay(alignment: .leading) {
                    Image(systemName: K.Strings.docOndoc)
                        .onTapGesture {
                            pasteboard.string = credential.password
                            
                            withAnimation {
                                copied = true
                            }
                        }
                        .offset(x: -36, y: 0)
                        .foregroundStyle(Color(K.Strings.myGreen))
                }
                
                if copied {
                    ToastView(copied: copied)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}


#Preview {
    PasswordCell(credential: Credential(name: "name", oldName: "oldName", username: "username", oldUsername: "oldUsername", password: "password", oldPassword: "old password (optional)", creationDate: "10/10/1985", lastChanged: "10/10/2023"), password: .constant("password"))
}
