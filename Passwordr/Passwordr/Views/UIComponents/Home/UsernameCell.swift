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
                    Text(credential.username)
                    Spacer()
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "pencil")
                        .onTapGesture {
                            onEditTap?()
                        }
                        .offset(x: 16, y: 0)
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
                }
                
                if copied {
                    Text("Copied to clipboard!")
                        .frame(width: 170, height: 28)
                        .foregroundStyle(.pink)
                        .background(Capsule())
                        .position(x: geo.frame(in: .local).width/2)//, y: 5)
                        .transition(.move(edge: .top))
                        .padding(.top)
                        .animation(.easeInOut(duration: 2), value: 1.0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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

