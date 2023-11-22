//
//  FaceIDTitle.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import SwiftUI

struct FaceIDTitle: View {
    var body: some View {
        Text("Passwordr")
            .font(.largeTitle)
            .foregroundStyle(Color("myGreen"))
    }
}

struct FaceIDTitle_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDTitle()
            .background(LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple],
                                       startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
