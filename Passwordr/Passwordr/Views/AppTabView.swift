//
//  AppTabView.swift
//  Passwordr
//
//  Created by Rafael Plinio on 29/11/23.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreen?

    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreen.allCases) { screen in
                screen.destination
                    .tag(screen as AppScreen?)
                    .tabItem { screen.label }
            }
        }
    }
}

#Preview {
    AppTabView(selection: .constant(.credentials))
}
