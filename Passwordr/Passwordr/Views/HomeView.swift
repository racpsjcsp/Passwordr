//
//  HomeView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel = HomeViewViewModel()

    var body: some View {
        if viewModel.isAuthenticated {
            CredentialsView()
        } else {
            VStack(spacing: 40) {
                FaceIDTitle()

                FaceIDButton(image: K.Strings.faceID, text: K.Strings.authScreenTitle)
                    .onTapGesture {
                        Task {
                            await viewModel.authenticateWithFaceID()
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
