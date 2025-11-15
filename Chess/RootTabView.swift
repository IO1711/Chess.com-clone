//
//  RootTabView.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI

struct RootTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            ChessBoardScreen()
                .tabItem {
                    Label("Play", systemImage: "checkerboard.rectangle")
                }

            Text("Settings coming soon")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}


#Preview {
    RootTabView()
}
