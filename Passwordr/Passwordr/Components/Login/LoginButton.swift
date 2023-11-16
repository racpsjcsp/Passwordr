//
//  LoginButton.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import SwiftUI

struct LoginButton: View {
    var image: String?
    var showImage = true
    var text: String
    
    var body: some View {
        HStack {
            if showImage {
                Image(systemName: image ?? "person.fill")
            }
            
            Text(text)
        }
        .padding()
        .padding(.horizontal)
        .background(.white)
        .foregroundColor(.black)
        .cornerRadius(30)
        .shadow(radius: 10)
    }
}

struct LoginButton_Previews: PreviewProvider {
    static var previews: some View {
        LoginButton(image: "faceid", text: "Login with FaceID")
    }
}
