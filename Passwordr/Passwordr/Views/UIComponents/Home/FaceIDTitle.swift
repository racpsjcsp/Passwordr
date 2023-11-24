//
//  FaceIDTitle.swift
//  Passwordr
//
//  Created by Rafael Plinio on 15/11/23.
//

import SwiftUI

struct FaceIDTitle: View {
    var body: some View {
        Text(K.Strings.appTitle)
            .font(.largeTitle)
            .foregroundStyle(Color(K.Strings.myGreen))
    }
}

struct FaceIDTitle_Previews: PreviewProvider {
    static var previews: some View {
        FaceIDTitle()
    }
}
