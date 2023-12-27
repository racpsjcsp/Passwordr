//
//  ThanksView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 27/12/23.
//

import SwiftUI

struct ThanksView: View {
    var didTapClose: () -> ()
    
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack(spacing: 8) {
            Text(K.Strings.thanksViewTitle)
                .font(.system(.title2, design: .rounded).bold())
                .multilineTextAlignment(.center)
                .foregroundColor(.myBlue)

            Text(K.Strings.thanksViewDescription)
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .foregroundColor(.myWhite)
                .padding(.bottom, 16)

            Button(action: didTapClose) {
                Text(K.Strings.thanksViewButtonTitle)
                    .font(.system(.title3, design: .rounded).bold())
                    .tint(.myWhite)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
        }
        .padding(16)
        .background(Color(uiColor: .myDarkGray),
                    in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .padding([.leading, .trailing], 10)
    }
}

#Preview {
    ThanksView { }
}
