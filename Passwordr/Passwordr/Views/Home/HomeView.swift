//
//  HomeView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewViewModel()
    
    var body: some View {
        if viewModel.isAuthenticated {
            List(0..<5) { item in
                VStack {
                    HStack {
                        Text("username")
                        Spacer()
                        Button(action: {
                            print("Button Tapped")
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.vertical, 8)
                    
                    HStack {
                        Text("password")
                        Spacer()
                        Button(action: {
                            print("Button Tapped")
                        }) {
                            Image(systemName: "eye.slash.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }
                    }
                }
            }
        } else {
            VStack(spacing: 40) {
                FaceIDTitle()
                
                FaceIDButton(image: "faceid", text: "Login with FaceID")
                    .onTapGesture {
                        Task {
                            await viewModel.authenticateWithFaceID()
                        }
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple],
                                       startPoint: .topLeading, endPoint: .bottomTrailing))
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
