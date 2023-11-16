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
            .bold()
            .font(.largeTitle)
            .foregroundStyle(Color.white.shadow(.inner(color: .black, radius: 1, x: 2, y: 2)))
    }
}

struct FaceIDTitle_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDTitle()
            .background(LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .indigo, .purple],
                                       startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
