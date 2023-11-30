//
//  ToastView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 19/11/23.
//

import SwiftUI

struct ToastView: View {
    @State var toastMessage: String

    @State var copied: Bool = false {
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
            if copied {
                Text(toastMessage)
                    .frame(width: 250, height: 30, alignment: .center)
                    .foregroundStyle(.red)
                    .background(Capsule())
                    .position(x: geo.frame(in: .local).width/2)
                    .transition(.move(edge: .top))
                    .padding(.top)
                    .animation(.easeInOut(duration: 2), value: 1.0)
            }
        }
    }
}

#Preview {
    ToastView(toastMessage: "copied to clipboard (60s)", copied: true)
}
