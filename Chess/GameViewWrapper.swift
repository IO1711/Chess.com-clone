//
//  GameViewWrapper.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI

struct GameViewWrapper: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> GameViewController {
        GameViewController()          // your existing controller
    }

    func updateUIViewController(_ uiViewController: GameViewController,
                                context: Context) {
        // nothing to update for now
    }
}


#Preview {
    GameViewWrapper()
}
