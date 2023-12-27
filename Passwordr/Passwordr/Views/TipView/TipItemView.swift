//
//  TipItemView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 27/12/23.
//

import SwiftUI
import StoreKit

struct TipItemView: View {
    @EnvironmentObject private var store: TipStore
    @Environment(\.colorScheme) var colorScheme
    
    let item: Product?

    var body: some View {
        HStack {
            VStack(alignment: .leading,
                   spacing: 3) {
                Text(item?.displayName ?? "Title")
                    .font(.system(.title3, design: .rounded).bold())
                    .foregroundStyle(.myBlack)
                Text(item?.description ?? "Description")
                    .font(.system(.callout, design: .rounded).weight(.regular))
                    .foregroundStyle(.myBlack)
            }

            Spacer()

            Button(item?.displayPrice ?? "-") {
                if let item = item {
                    Task {
                        await store.purchase(item: item)
                    }
                }
            }
            .foregroundStyle(.myBlue)
            .buttonStyle(.bordered)
            .font(.callout.bold())
            .background(.myLightGray, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        }
        .padding(16)
        .background(.myLightGray, in: RoundedRectangle(cornerRadius: 12, style: .continuous))
        .padding([.leading, .trailing], 12)
    }
}

#Preview {
    TipItemView(item: nil)
        .environmentObject(TipStore())
}
