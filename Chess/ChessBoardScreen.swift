//
//  ChessBoardScreen.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 15/11/25.
//

import SwiftUI
import SpriteKit

struct ChessBoardScreen: View {
    
    private var scene: SKScene {
        let scene = GameScene(size: CGSize(width: 800, height: 800))
        scene.scaleMode = .resizeFill
        return scene
    }
    
    

    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            SpriteView(scene: scene)
                .ignoresSafeArea()
        }
    }
}
//world's best code is down somewhere


#Preview {
    ChessBoardScreen()
}
