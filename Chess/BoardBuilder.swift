//
//  BoardBuilder.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 10/11/25.
//

import Foundation
import SpriteKit

class BoardBuilder {
    /*private let cols = 8
    private let rows = 8
    private var tileSize: CGFloat = 0
    private var boardOrigin = CGPoint.zero
    
    private func buildBoard(){
        let boardSize = min(frame.width, frame.height) * 0.9
        
        
        
        
        tileSize = boardSize/CGFloat(cols)
        
        boardOrigin = CGPoint(
            x: frame.midX - boardSize/2,
            y: frame.midY - boardSize/2
        )
        
        for r in 0..<rows{
            for c in 0..<cols{
                let color = ((r+c)%2==0 ? SKColor(white: 0.93, alpha: 1) : SKColor(white: 0.3, alpha: 1))
                
                let tile = SKSpriteNode(color: color, size: CGSize(width: tileSize, height: tileSize))
                let tileNote = SKLabelNode()
                
                tile.anchorPoint = CGPoint.zero
                
                tile.position = CGPoint(
                    x: boardOrigin.x + CGFloat(c) * tileSize,
                    y: boardOrigin.y + CGFloat(r) * tileSize
                )
                
                tile.zPosition = 0
                
                tileNote.text = "\(r)-\(c)"
                tileNote.fontColor = .red
                tileNote.fontSize = 15
                tileNote.position = CGPoint(
                    x: tile.position.x, y: tile.position.y
                )
                tileNote.zPosition = 2
                addChild(tileNote)
                addChild(tile)
            }
        }
    }*/
}
