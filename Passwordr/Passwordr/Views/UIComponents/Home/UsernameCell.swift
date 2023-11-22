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
                    Image(systemName: "pencil")
                        .onTapGesture {
                            onEditTap?()
                        }
                        .offset(x: 16, y: 0)
                        .foregroundStyle(Color("myGreen"))
                }
                .overlay(alignment: .leading) {
                    Image(systemName: "doc.on.doc")
                        .onTapGesture {
                            pasteboard.string = credential.username
                            if let string = pasteboard.string {
                                print("clipboard string: \(string)")
                            }
                            
                            withAnimation {
                                copied = true
                            }
                        }
                        .offset(x: -36, y: 0)
                        .foregroundStyle(Color("myGreen"))
                }
                
                if copied {
                    Text("Copied to clipboard!")
                        .frame(width: 170, height: 28)
                        .foregroundStyle(.green)
                        .background(Capsule())
                        .position(x: geo.frame(in: .local).width/2)
                        .transition(.move(edge: .top))
                        .padding(.top)
                        .animation(.easeInOut(duration: 2), value: 1.0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

extension UsernameCell {
    func onEditTap(action: @escaping (() -> Void), credential: Credential) -> UsernameCell {
        UsernameCell(credential: Credential(name: "name", username: "username", password: "password", oldPassword: "old password (optional)", creationDate: "10/10/1985", lastChanged: "10/10/2023"), onEditTap: action, username: .constant(username))
    }
}
