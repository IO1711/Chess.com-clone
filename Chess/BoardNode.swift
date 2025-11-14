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

enum Player{
    case white
    case black
}

private struct Square: Hashable { let col: Int; let row: Int }


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
    
    
    private var dragStartSquare: Square?
    private var legalTargets = Set<Square>()

    private var occupancy = [Square: PieceNode]()
    
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
    
    func addPiece(pieceType: PieceTypes, col: Int, row: Int){
        /*let x = origin.x + CGFloat(col) * tileSize + tileSize/2
        let y = origin.y + CGFloat(row) * tileSize + tileSize/2
        
        let pieceTexture = SKTexture(imageNamed: "\(pieceType.rawValue)")
        
        let piece = SKSpriteNode(texture: pieceTexture, size: CGSize(width: tileSize*0.9, height: tileSize*0.9))
        
        piece.zPosition = Z.pieces
        //piece.anchorPoint = .zero
        piece.position = CGPoint(x: x, y: y)
        
        let colLetter = String(Character(UnicodeScalar(97+col)!))
        
        piece.name = "\(pieceType.rawValue)_\(colLetter)\(row)"*/
        
        let piece = PieceNode(col: col, row: row, type: pieceType, tileSize: tileSize, origin: origin, board: self)
        
        let square = Square(col: col, row: row)
        
        occupancy[square] = piece
        
        piecesLayer.addChild(piece)
        
        let sq = Square(col: col, row: row)
        occupancy[sq] = piece
        
        
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
    
    /*func beginDrag(at point: CGPoint){
        
        let foundPiece = piece(at: point)
        
        guard let foundPiece = foundPiece else {
            return
        }
        
        draggedPiece = foundPiece
        
        isDragging = true
        
        foundPiece.zPosition = Z.pieces + 1
    }*/
    
    func beginDrag(at point: CGPoint){
        guard let found = piece(at: point) else { return }
        draggedPiece = found
        isDragging = true
        found.zPosition = Z.pieces + 1

        // NEW: only if it's our PieceNode, ask it for moves
        if let p = found as? PieceNode {
            // 1) remember start
            let start = p.currentSquare
            dragStartSquare = Square(col: start.col, row: start.row)

            // 2) get raw [[row,col]] from behaviour
            let raw = p.legalMoves()

            // 3) map/filter to board Squares
            let mapped = raw.compactMap { arr -> Square? in
                guard arr.count == 2 else { return nil }
                let r = arr[0], c = arr[1]
                return isInsideBoard(col: c, row: r) ? Square(col: c, row: r) : nil
            }

            legalTargets = Set(mapped)

            // 4) highlight
            showHighlights(legalTargets)
        } else {
            legalTargets.removeAll()
            clearHighlights()
            dragStartSquare = nil
        }
    }

    
    func updateDrag(at point: CGPoint){
        
        guard isDragging else {return}
        
        guard let piece = draggedPiece else {return}
        
        let clampedPoint = clampedPosition(point)
        
        piece.position = clampedPoint
        
        /*var pieceName = SKLabelNode(fontNamed: "Chalkduster")
        pieceName.text = piece.name
        let x = origin.x + 50
        let y = origin.y - 50
        pieceName.position = CGPoint(x: x, y: y)
        tilesLayer.addChild(pieceName)*/
    }
    
    /*func endDrag(){
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
    }*/
    
    func endDrag(){
        guard isDragging, let node = draggedPiece else { return }

        // where did user drop?
        let drop = squareFrom(node.position) // helper below
        let dropSquare = Square(col: drop.col, row: drop.row)

        // decide final square
        let final: Square
        if legalTargets.contains(dropSquare) {
            final = dropSquare
            
            
            
            if let start = dragStartSquare,
               let piece = node as? PieceNode {
                if isOccupied(col: final.col, row: final.row) && isEnemy(pieceName: piece.name!, col: final.col, row: final.row){
                    if let victim = occupiedPiece(at: final.col, row: final.row) {
                        victim.removeFromParent()
                        
                        let victimSquare = Square(col: final.col, row: final.row)
                        occupancy[victimSquare] = nil
                    }
                }
                
                updatePiecePosition(piece, from: start, to: final)
            }
            
            
        } else if let start = dragStartSquare {
            final = start // revert to start if illegal
        } else {
            final = dropSquare // fallback
        }

        // animate to final
        let targetCenter = positionForSquare(col: final.col, row: final.row)
        node.run(SKAction.move(to: targetCenter, duration: 0.12))

        // if it’s our PieceNode and move was legal, update its stored row/col
        if let p = node as? PieceNode, legalTargets.contains(final) {
            p.updatePosition(col: final.col, row: final.row)
            
        }

        // cleanup
        node.zPosition = Z.pieces
        isDragging = false
        draggedPiece = nil
        dragStartSquare = nil
        legalTargets.removeAll()
        clearHighlights()
    }

    private func squareFrom(_ position: CGPoint) -> (col: Int, row: Int) {
        let s = snapToGrid(position)
        return (col: s.col, row: s.row)
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
    
    
    private func isInsideBoard(col: Int, row: Int) -> Bool {
        (0..<cols).contains(col) && (0..<rows).contains(row)
    }

    private func showHighlights(_ squares: Set<Square>) {
        highlightLayer.removeAllChildren()
        for s in squares {
            let p = positionForSquare(col: s.col, row: s.row)
            let dot = SKShapeNode(circleOfRadius: tileSize * 0.18)
            dot.position = p
            dot.zPosition = Z.highlight
            dot.fillColor = .systemBlue.withAlphaComponent(0.35)
            dot.strokeColor = .clear
            highlightLayer.addChild(dot)
        }
    }

    private func clearHighlights() {
        highlightLayer.removeAllChildren()
    }

    
    func occupiedPiece(at col: Int, row: Int)-> PieceNode?{
        let sq = Square(col: col, row: row)
        return occupancy[sq]
    }
    
    func isOccupied(col: Int, row: Int)->Bool{
        occupiedPiece(at: col, row: row) != nil
    }
    
    private func updatePiecePosition(_ piece: PieceNode, from: Square, to: Square){
        occupancy[from] = nil
        occupancy[to] = piece
    }
    
    func isEnemy(pieceName: String, col: Int, row: Int)->Bool{
        
        let piece = occupiedPiece(at: col, row: row)
        
        if let name = piece?.name {
            if name.contains("white") && pieceName.contains("black"){
                return true
            } else if name.contains("black") && pieceName.contains("white"){
                return true
            }
        }
        
        return false
    }
    
}
