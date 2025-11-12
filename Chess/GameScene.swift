//
//  GameScene.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 07/11/25.
//

import SpriteKit

class GameScene: SKScene {
    
    private var board = BoardNode(cols: 8, rows: 8)
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        
        let location = touch.location(in: self)
        
        board.beginDrag(at: location)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {return}
        
        let location = touch.location(in: self)
        
        board.updateDrag(at: location)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        board.endDrag()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        board.endDrag()
    }
    
    private func buildBoard(){
        addChild(board)
        board.layout(in: frame)
        board.buildGrid()
        
        board.addPiece(pieceType: .black_bishop, col: 2, row: 3)
        board.addPiece(pieceType: .white_bishop, col: 4, row: 0)
    }


    override func didMove(to view: SKView) {
        backgroundColor = .systemTeal
        
        buildBoard()
        
        
        /*let label = SKLabelNode(text: "This is my scene!")
        label.position = CGPoint(x: size.width/2, y: size.height/2)
        label.fontName = "Avenir-Heavy"
        label.fontSize = 28
        addChild(label)
        
        let box = SKSpriteNode(color: .white, size: CGSize(width: 100, height: 100))
        box.position = CGPoint(x: size.width/2, y: size.height/2 + 150)
        box.name = "box"
        addChild(box)*/
    }
}
