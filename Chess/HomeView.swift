//
//  HomeView.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Text("Chess")
                    .font(.largeTitle.bold())

                Text("Play online, practice vs bot, or analyze games.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // This is your "Play" button → opens board screen
                NavigationLink {
                    ChessBoardScreen()
                } label: {
                    Text("Play")
                        .font(.headline)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 12)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }

                Spacer()
            }
            .padding()
        }
    }
}


#Preview {
    HomeView()
}
