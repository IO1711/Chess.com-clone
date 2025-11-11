//
//  GameScene.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 07/11/25.
//

import SpriteKit

class GameScene: SKScene {
    
    private let cols = 8
    private let rows = 8
    private var tileSize: CGFloat = 0
    private var boardOrigin = CGPoint.zero
    
    private var piece: SKSpriteNode!
    private var dragging: Bool = false
    
    private func addPiece(){
        piece = SKSpriteNode(color: .systemRed, size: CGSize(width: tileSize*0.9, height: tileSize*0.9))
        piece.name = "piece"
        piece.zPosition = 3
        placePiece(atCol: 0, row: 5)
        addChild(piece)
    }
    
    private func placePiece(atCol c: Int, row r: Int){
        let x = boardOrigin.x + CGFloat(c) * tileSize + tileSize/2
        let y = boardOrigin.y + CGFloat(r) * tileSize + tileSize/2
        piece.position = CGPoint(x: x, y: y)
    }
    
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
    }
    
    
    
    private func snapToGrid(_ pos: CGPoint) -> (col: Int, row: Int) {
        let localX = pos.x - boardOrigin.x
        let localY = pos.y - boardOrigin.y
        let c = Int(round(localX / tileSize - 0.5))
        let r = Int(round(localY / tileSize - 0.5))
        return (max(0, min(cols-1, c)), max(0, min(rows-1, r)))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let t = touches.first else { return }
        let location = t.location(in: self)
        if nodes(at: location).contains(where: { $0.name == "piece" }) {
            dragging = true
            piece.zPosition = 3
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard dragging, let t = touches.first else { return }
        var p = t.location(in: self)
        // clamp inside board rect
        let minX = boardOrigin.x + tileSize/2
        let maxX = boardOrigin.x + CGFloat(cols-1)*tileSize + tileSize/2
        let minY = boardOrigin.y + tileSize/2
        let maxY = boardOrigin.y + CGFloat(rows-1)*tileSize + tileSize/2
        p.x = max(minX, min(maxX, p.x))
        p.y = max(minY, min(maxY, p.y))
        piece.position = p
        
        let cr = snapToGrid(piece.position)
        showHighlight(atCol: cr.col, row: cr.row)
    }
    
    private var highlight: SKSpriteNode?

    private func showHighlight(atCol c: Int, row r: Int) {
        highlight?.removeFromParent()
        /*let rect = CGRect(x: boardOrigin.x + CGFloat(c)*tileSize,
                          y: boardOrigin.y + CGFloat(r)*tileSize,
                          width: tileSize, height: tileSize)
        let node = SKShapeNode(rect: rect, cornerRadius: 6)*/
        let rect = SKSpriteNode(color: .systemPurple, size: CGSize(width: tileSize, height: tileSize))
        //node.lineWidth = 4
        //node.strokeColor = .yellow
        //node.zPosition = 3
        rect.position = CGPoint(x: boardOrigin.x + CGFloat(c)*tileSize + tileSize/2, y: boardOrigin.y + CGFloat(r)*tileSize + tileSize/2)
        rect.zPosition = 2
        rect.alpha = 0.5
        addChild(rect)
        highlight = rect
    }


    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        endDrag()
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        endDrag()
    }
    
    

    private func animateMove(toCol c: Int, row r: Int) {
        let target = CGPoint(x: boardOrigin.x + CGFloat(c)*tileSize + tileSize/2,
                             y: boardOrigin.y + CGFloat(r)*tileSize + tileSize/2)
        piece.run(.move(to: target, duration: 0.12))
    }

    private var currentCR = (col: 3, row: 3)

    private func endDrag() {
        guard dragging else { return }
        dragging = false
        highlight?.removeFromParent()
        piece.zPosition = 2
        let snapped = snapToGrid(piece.position)
        currentCR = snapped
        animateMove(toCol: snapped.col, row: snapped.row)
    }


    override func didMove(to view: SKView) {
        backgroundColor = .systemTeal
        
        buildBoard()
        addPiece()
        
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
