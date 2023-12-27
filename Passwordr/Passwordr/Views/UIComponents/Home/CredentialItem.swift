//
//  CredentialItem.swift
//  Passwordr
//
//  Created by Rafael Plinio on 24/12/23.
//

import SwiftUI

struct CredentialItem: View {
    @State var showShareSheet = false
    let credential: Credential

    var body: some View {
        HStack {
            Image(systemName: K.Image.squareAndArrowUp)
                .onTapGesture {
                    showShareSheet.toggle()
                }
                .offset(x: -10, y: 0)
                .foregroundStyle(Color(.myBlue))
                .sheet(isPresented: $showShareSheet) {
                    ActivityView(credential: credential)
                }

            Text(credential.title)
                .foregroundStyle(Color(.myBlue))

            Spacer()
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {
    @State var credential: Credential

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let sharedTitle = "Here is my credentials for \(credential.title):"
        let sharedInfo = "Username: \(credential.username)\nPassword: \(credential.password)"
        let test = "\(sharedTitle)\n\n\(sharedInfo)"
        let activityViewController = UIActivityViewController(activityItems: [test], applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Update the view controller if needed
    }
}
