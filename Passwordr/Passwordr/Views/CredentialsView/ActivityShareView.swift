//
//  ActivityShareView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 24/12/23.
//

import SwiftUI

struct ActivityShareView: UIViewControllerRepresentable {
    @State var credential: Credential

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let sharedTitle = "Here is my credentials for \(credential.title):"
        let sharedBody = "Username: \(credential.username)\nPassword: \(credential.password)"
        let sharedInfo = "\(sharedTitle)\n\n\(sharedBody)"
        let activityViewController = UIActivityViewController(activityItems: [sharedInfo], applicationActivities: nil)
        return activityViewController
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // Update the view controller if needed
    }
}
