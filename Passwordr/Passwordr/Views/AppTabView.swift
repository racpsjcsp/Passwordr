//
//  AppTabView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 29/11/23.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?
    @StateObject var store: TipStore = TipStore()

    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
        .tint(.myBlue)
        .environmentObject(store)
    }
}

#Preview {
    AppTabView(selection: .constant(.credentials))
}
