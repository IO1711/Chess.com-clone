//
//  PieceNode.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 12/11/25.
//

import Foundation
import SpriteKit

typealias Movement = (_ row: Int, _ col: Int, _ id: String, _ board: BoardNode) -> [[Int]]

@MainActor
class PieceNode : SKSpriteNode {
    unowned let board: BoardNode
    
    private(set) var col : Int
    
    private(set) var row : Int
    
    private var type : PieceTypes
    
    private var behaviour: Movement
    
    init(col: Int, row: Int, type: PieceTypes, tileSize: CGFloat, origin: CGPoint, behaviour: Movement? = nil, board: BoardNode) {
        
        let x = origin.x + CGFloat(col) * tileSize + tileSize/2
        let y = origin.y + CGFloat(row) * tileSize + tileSize/2
        
        
        
        
        self.col = col
        self.row = row
        self.type = type
        self.board = board
        
        if let custom = behaviour {
            self.behaviour = custom
        } else {
            switch type {
            case .white_pawn, .black_pawn :
                    self.behaviour = PiecesLogic.pawn
            case .white_bishop, .black_bishop :
                self.behaviour = PiecesLogic.bishop
            case .white_rook, .black_rook :
                self.behaviour = PiecesLogic.rook
            case .white_knight, .black_knight :
                self.behaviour = PiecesLogic.knight
            case .white_queen, .black_queen :
                self.behaviour = PiecesLogic.queen
            case .white_king, .black_king :
                self.behaviour = PiecesLogic.king
            }
        }
        
        let pieceTexture = SKTexture(imageNamed: "\(type.rawValue)")
        super.init(texture: pieceTexture, color: .clear, size: CGSize(width: tileSize*0.9, height: tileSize*0.9))
        
        self.position = CGPoint(x: x, y: y)
        
        let colLetter = String(Character(UnicodeScalar(97+col)!))
        
        self.name = "\(type.rawValue)_\(colLetter)\(row)"
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var currentSquare: (col: Int, row: Int) { (col, row) }

    func updatePosition(col: Int, row: Int) {
        self.col = col
        self.row = row
    }

    
    func legalMoves() -> [[Int]]{
        behaviour(row, col, name ?? type.rawValue, board)
    }
}
