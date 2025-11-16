//
//  CustomTabBar.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selection: MainTab

    // chess.com-like colors
    private let tabBarBackground = Color.black
    //Color(red: 34/255, green: 36/255, blue: 35/255)
    private let activeGreen      = Color(red: 141/255, green: 199/255, blue: 62/255)
    private let inactiveGray = Color(red: 150/255, green: 150/255, blue: 150/255)

    //private let inactiveGray     = Color.white.opacity(0.6)

    var body: some View {
        VStack(spacing: 0) {
            // thin top divider line
            Rectangle()
                .fill(Color.clear)
                //.fill(Color.black.opacity(0.4))
                .frame(height: 0.5)

            HStack(spacing: 0) {
                tabButton(
                    tab: .home,
                    title: "Home",
                    systemImage: "house.fill"
                )

                tabButton(
                    tab: .puzzles,
                    title: "Puzzles",
                    systemImage: "puzzlepiece.fill"
                )

                tabButton(
                    tab: .learn,
                    title: "Learn",
                    systemImage: "graduationcap.fill"
                )

                tabButton(
                    tab: .watch,
                    title: "Watch",
                    systemImage: "binoculars.fill"
                )

                tabButton(
                    tab: .more,
                    title: "More",
                    systemImage: "line.3.horizontal"
                )
            }
            .padding(.horizontal, 10)
            .padding(.top, 6)
            .padding(.bottom, 10)   // sits nicely above the home indicator
        }
        .background(
            tabBarBackground
                .ignoresSafeArea(edges: .bottom)
        )
    }

    private func tabButton(
        tab: MainTab,
        title: String,
        systemImage: String
    ) -> some View {
        let isSelected = (selection == tab)

        return Button {
            selection = tab
        } label: {
            VStack(spacing: 3) {
                Image(systemName: systemImage)
                    .font(.system(size: 20, weight: .semibold))

                Text(title)
                    .font(.caption2.weight(.semibold))
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 4)
            .foregroundStyle(isSelected ? activeGreen : inactiveGray)
        }
    }
}

/*#Preview {
    CustomTabBar()
}*/

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()   // so you see how it looks on black

        VStack {
            Spacer()                    // push bar to the bottom
            CustomTabBar(selection: .constant(.home))
        }
    }
}

