//
//  TipView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 27/12/23.
//

import SwiftUI
import StoreKit

struct TipView: View {
    @EnvironmentObject private var store: TipStore
    @State private var showThanks = false

    var body: some View {
        VStack(spacing: 1) {
            Text(K.Strings.tipViewTitle)
                .font(.system(.title2, design: .rounded).bold())
                .foregroundColor(.myBlue)
                .padding()

            Text(K.Strings.tipViewDescription)
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)

            ForEach(store.items, id: \.self) { item in
                TipItemView(item: item)
                    .padding([.top, .bottom], 4)
            }
        }
        .onChange(of: store.action) {
            if store.action == .successful {
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    showThanks.toggle()
                    store.reset()
                }
            }
        }
        .overlay(alignment: .bottom) {
            if showThanks {
                ThanksView {
                    showThanks.toggle()
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 1.0), value: showThanks)
        .alert(isPresented: $store.hasError, error: store.error) {}
        .padding([.leading, .trailing], 16)
    }
}
#Preview {
    TipView()
        .environmentObject(TipStore())
}
