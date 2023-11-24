//
//  ToastView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 19/11/23.
//

import SwiftUI

struct ToastView: View {
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
                Text(K.Strings.clipboardMessage)
                    .frame(width: 170, height: 28)
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
    ToastView(copied: true)
}
