//
//  RootTabView.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI



/*struct RootTabView: View {
    @State private var selectedTab: MainTab = .home

    var body: some View {
        ZStack {
            // This is the real background for the whole screen
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // main content
                ZStack {
                    switch selectedTab {
                    case .home:
                        HomeView()

                    case .puzzles:
                        Text("Puzzles coming soon")
                            .foregroundStyle(.white)

                    case .learn:
                        Text("Learn coming soon")
                            .foregroundStyle(.white)

                    case .watch:
                        Text("Watch coming soon")
                            .foregroundStyle(.white)

                    case .more:
                        Text("More / Settings coming soon")
                            .foregroundStyle(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // fully transparent tab bar
                CustomTabBar(selection: $selectedTab)
            }
        }
        .ignoresSafeArea()
    }
}


#Preview {
    RootTabView()
}*/

struct RootTabView: View {
    @State private var selectedTab: MainTab = .home

    var body: some View {
        NavigationStack {
            ZStack {
                // Global background for the whole app
                Color.black
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    ZStack {
                        switch selectedTab {
                        case .home:
                            HomeView()   // 👉 now a plain view, no NavigationStack inside

                        case .puzzles:
                            Text("Puzzles coming soon")
                                .foregroundStyle(.white)

                        case .learn:
                            Text("Learn coming soon")
                                .foregroundStyle(.white)

                        case .watch:
                            Text("Watch coming soon")
                                .foregroundStyle(.white)

                        case .more:
                            Text("More / Settings coming soon")
                                .foregroundStyle(.white)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                    CustomTabBar(selection: $selectedTab)
                }
            }
            // hide nav bar chrome so it doesn't introduce extra backgrounds
            .toolbar(.hidden, for: .navigationBar)
        }
        .background(Color.black)
        .ignoresSafeArea()
    }
}

#Preview {
    RootTabView()
}

