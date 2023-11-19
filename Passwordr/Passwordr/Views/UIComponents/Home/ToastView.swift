//
//  ToastView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 19/11/23.
//

import SwiftUI

struct ToastView: View {
    @State var copied2: Bool = false {
        didSet {
            if copied2 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        copied2 = false
                    }
                }
            }
        }
    }
    @State private var copied = false {
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
            ZStack {
                if copied2 {
                    Text("Copied to clipboard!")
                        .frame(width: 170, height: 28)
                        .foregroundStyle(.pink)
                        .background(Capsule())
                        .position(x: geo.frame(in: .local).width/2)//, y: 5)
                        .transition(.move(edge: .top))
                        .padding(.top)
                        .animation(.easeInOut(duration: 2), value: 1.0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

#Preview {
    ToastView(copied2: true)
}
