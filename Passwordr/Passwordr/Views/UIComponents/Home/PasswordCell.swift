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
                    Image(systemName: isSecureField ? K.Image.eye : K.Image.eyeSlash)
                        .onTapGesture {
                            isSecureField.toggle()
                        }
                        .offset(x: 16, y: 0)
                        .foregroundStyle(Color(.myGreen))
                }
                .overlay(alignment: .leading) {
                    Image(systemName: K.Image.docOndoc)
                        .onTapGesture {
                            let expireDate = Date().addingTimeInterval(TimeInterval(60))
                            UIPasteboard.general.setItems([[UIPasteboard.typeAutomatic: credential.password]],
                                                          options: [UIPasteboard.OptionsKey.expirationDate: expireDate])
                            
                            withAnimation {
                                copied = true
                            }
                        }
                        .offset(x: -36, y: 0)
                        .foregroundStyle(Color(.myGreen))
                }
                
                if copied {
                    ToastView(toastMessage: K.Strings.clipboardPasswordMessage, copied: copied)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
