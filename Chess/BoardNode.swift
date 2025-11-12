//
//  BoardNode.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 11/11/25.
//

import Foundation
import SpriteKit

private enum LayoutRatio {
    static let boardFill: CGFloat = 0.9
}

private enum Z {
    static let tiles: CGFloat = 0
    static let highlight: CGFloat = 2
    static let pieces: CGFloat = 3
}

public enum PieceType: String {
    case white_pawn, white_rook, white_knight, white_bishop, white_queen, white_king
    case black_pawn, black_rook, black_knight, black_bishop, black_queen, black_king
}

class BoardNode: SKNode{
    
    private let cols: Int
    
    private let rows: Int
    
    private(set) var tileSize: CGFloat = 0
    private(set) var origin: CGPoint = .zero
    private(set) var boardSize: CGFloat = 0
    
    private let tilesLayer: SKNode
    private let piecesLayer: SKNode
    private let highlightLayer: SKNode
    
    private var draggedPiece: SKSpriteNode!
    private var isDragging: Bool = false
    
    init(cols: Int, rows: Int) {
        
        self.cols = cols
        self.rows = rows
        tilesLayer = SKNode()
        piecesLayer = SKNode()
        highlightLayer = SKNode()
        super.init()
        
        addChild(tilesLayer)
        addChild(highlightLayer)
        addChild(piecesLayer)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layout(in frame: CGRect){
        boardSize = min(frame.width, frame.height) * LayoutRatio.boardFill
        tileSize = boardSize/CGFloat(cols)
        origin.x = frame.midX - boardSize/2
        origin.y = frame.midY - boardSize/2
        
        print(boardSize > 0)
    }
    
    func buildGrid(){
        tilesLayer.removeAllChildren()
        
        for row in 0..<rows{
            for col in 0..<cols{
                let x = origin.x + CGFloat(col)*tileSize
                let y = origin.y + CGFloat(row)*tileSize
                
                let color = ((row+col)%2==0 ? SKColor(red: 78/255, green: 120/255, blue: 55/255, alpha: 1) : SKColor(red: 255, green: 255, blue: 255, alpha: 1))
                
                let tile = SKSpriteNode(color: color, size: CGSize(width: tileSize, height: tileSize))
                
                //let tileNote = SKLabelNode()
                
                tile.anchorPoint = CGPoint(x: 0, y: 0)
                
                tile.position = CGPoint(x: x, y: y)
                
                tile.zPosition = Z.tiles
                
                tile.name = "tile_\(row)_\(col)"
                
                /*tileNote.text = "\(row)-\(col)"
                tileNote.fontColor = .red
                tileNote.fontSize = 15
                tileNote.position = CGPoint(
                    x: tile.position.x, y: tile.position.y
                )
                tileNote.zPosition = 2
                tilesLayer.addChild(tileNote)*/
                tilesLayer.addChild(tile)
            }
        }
    }
    
    func addPiece(pieceType: PieceType, col: Int, row: Int){
        let x = origin.x + CGFloat(col) * tileSize + tileSize/2
        let y = origin.y + CGFloat(row) * tileSize + tileSize/2
        
        let pieceTexture = SKTexture(imageNamed: "\(pieceType.rawValue)")
        
        let piece = SKSpriteNode(texture: pieceTexture, size: CGSize(width: tileSize*0.9, height: tileSize*0.9))
        
        piece.zPosition = Z.pieces
        //piece.anchorPoint = .zero
        piece.position = CGPoint(x: x, y: y)
        
        let colLetter = String(Character(UnicodeScalar(97+col)!))
        
        piece.name = "\(pieceType.rawValue)_\(colLetter)\(row)"
        
        piecesLayer.addChild(piece)
        
        
    }
    
    func piece(at point: CGPoint) -> SKSpriteNode? {
        let nodesAtPoint = piecesLayer.nodes(at: point)
        
        for node in nodesAtPoint{
            if let spriteNode = node as? SKSpriteNode {
                if let name = spriteNode.name, name.contains("pawn") || name.contains("rook") || name.contains("knight") || name.contains("bishop") || name.contains("queen") || name.contains("king"){
                    return spriteNode
                }
            }
        }
        
        return nil
    }
    
    func clampedPosition(_ point: CGPoint) -> CGPoint {
        
        let minX = origin.x + tileSize/2
        
        let maxX = origin.x + CGFloat(cols - 1) * tileSize + tileSize / 2
            
            // STEP 3: Calculate bottom boundary (minimum Y)
        let minY = origin.y + tileSize / 2
            
            // STEP 4: Calculate top boundary (maximum Y)
        let maxY = origin.y + CGFloat(rows - 1) * tileSize + tileSize / 2
        
        var clampedX = point.x
        clampedX = max(minX, clampedX)
        clampedX = min(maxX, clampedX)
        
        let clampedY = max(minY, min(maxY, point.y))
        
        return CGPoint(x: clampedX, y: clampedY)
    }
    
    func beginDrag(at point: CGPoint){
        
        let foundPiece = piece(at: point)
        
        guard let foundPiece = foundPiece else {
            return
        }
        
        draggedPiece = foundPiece
        
        isDragging = true
        
        foundPiece.zPosition = Z.pieces + 1
    }
    
    func updateDrag(at point: CGPoint){
        guard isDragging else {return}
        
        guard let piece = draggedPiece else {return}
        
        let clampedPoint = clampedPosition(point)
        
        piece.position = clampedPoint
    }
    
    func endDrag(){
        guard isDragging else {return}
        
        
        
        let currentPosition = draggedPiece.position
        
        let nearestSquare = snapToGrid(currentPosition)
        
        let targetCenter = positionForSquare(col: nearestSquare.col, row: nearestSquare.row)
        
        let moveAnimation = SKAction.move(to: targetCenter, duration: 0.12)
        draggedPiece.run(moveAnimation)
        if let piece = draggedPiece {
            piece.zPosition = Z.pieces
        }
        
        draggedPiece = nil
        
        isDragging = false
    }
    
    
    func snapToGrid(_ position: CGPoint) -> (col: Int, row: Int){
        let x = position.x - origin.x
        let y = position.y - origin.y
        
        let col = round(x/tileSize-0.5)
        let row = round(y/tileSize-0.5)
        
        return (col: Int(col), row: Int(row))
    }
    
    func positionForSquare(col: Int, row: Int) -> CGPoint {
        let x = origin.x + CGFloat(col) * tileSize + tileSize/2
        let y = origin.y + CGFloat(row) * tileSize + tileSize/2
        
        return CGPoint(x: x, y: y)
    }
    
    
}
