//
//  ChessBoardScreen.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI
import SpriteKit

struct ChessBoardScreen: View {
    // 1) create the scene for SwiftUI
    private var scene: SKScene {
        let scene = GameScene(size: CGSize(width: 800, height: 800))
        scene.scaleMode = .resizeFill   // important so it fills the view
        return scene
    }

    // 2) show it with SpriteView
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()   // or give it padding if you want UI around it
    }
}


#Preview {
    ChessBoardScreen()
}
