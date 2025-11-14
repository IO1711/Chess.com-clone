//
//  PiecesLogic.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 12/11/25.
//

import Foundation


class PiecesLogic {
    static func pawn(row: Int, col: Int, pieceName: String, board: BoardNode) -> [[Int]]{
        var availableTiles: [[Int]] = []
        
        if Int(pieceName.suffix(1))! < 3 && row < 2 {
            for i in row..<3 {
                var accessTile : [Int] = []
                
                accessTile.append(i+1)
                accessTile.append(col)
                
                if !board.isOccupied(col: col, row: i+1){
                    availableTiles.append(accessTile)
                } else {
                    break
                }
            }
        } else if Int(pieceName.suffix(1))! > 4 && row > 5 {
            var i = row
            while i > 4 {
                var accessTile : [Int] = []
                
                accessTile.append(i-1)
                accessTile.append(col)
                
                if !board.isOccupied(col: col, row: i-1){
                    availableTiles.append(accessTile)
                } else {
                    break
                }
                
                i-=1
            }
        } else if Int(pieceName.suffix(1))! < 3 && row > 1 {
            if !board.isOccupied(col: col, row: row+1){
                availableTiles.append([row+1,col])
            }
        } else if Int(pieceName.suffix(1))! > 4 && row < 6 {
            if !board.isOccupied(col: col, row: row-1){
                availableTiles.append([row-1, col])
            }
        }
        
        return availableTiles
    }
    
    static func bishop(row: Int, col: Int, pieceName: String, board: BoardNode) -> [[Int]]{
        var availableTiles: [[Int]] = []
        
        var i: Int = row
        var j: Int = col
        
        while i < 7 && j < 7 {
            var accessTile: [Int] = []
            
            accessTile.append(i+1)
            accessTile.append(j+1)
            if board.isOccupied(col: j+1, row: i+1) && board.isEnemy(pieceName: pieceName, col: j+1, row: i+1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j+1, row: i+1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            
            i+=1
            j+=1
        }
        
        i = row
        j = col
        
        while i > 0 && j > 0 {
            var accessTile: [Int] = []
            
            accessTile.append(i-1)
            accessTile.append(j-1)
            
            if board.isOccupied(col: j-1, row: i-1) && board.isEnemy(pieceName: pieceName, col: j-1, row: i-1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j-1, row: i-1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            i-=1
            j-=1
        }
        
        i = row
        j = col
        
        while i > 0 && j < 7 {
            var accessTile: [Int] = []
            
            accessTile.append(i-1)
            accessTile.append(j+1)
            
            if board.isOccupied(col: j+1, row: i-1) && board.isEnemy(pieceName: pieceName, col: j+1, row: i-1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j+1, row: i-1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            i-=1
            j+=1
        }
        
        i = row
        j = col
        
        while i < 7 && j > 0 {
            var accessTile: [Int] = []
            
            accessTile.append(i+1)
            accessTile.append(j-1)
            
            if board.isOccupied(col: j-1, row: i+1) && board.isEnemy(pieceName: pieceName, col: j-1, row: i+1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j-1, row: i+1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            i+=1
            j-=1
        }
        
        return availableTiles
    }
    
    static func rook(row: Int, col: Int, pieceName: String, board: BoardNode) -> [[Int]]{
        var availableTiles: [[Int]] = []
        
        var i = row
        var j = col
        
        while i < 7 {
            i+=1
            if board.isOccupied(col: col, row: i) && board.isEnemy(pieceName: pieceName, col: col, row: i){
                availableTiles.append([i,col])
                break
            } else if board.isOccupied(col: col, row: i){
                break
            }
            availableTiles.append([i,col])
            
        }
        
        while j < 7 {
            j+=1
            if board.isOccupied(col: j, row: row) && board.isEnemy(pieceName: pieceName, col: j, row: row){
                availableTiles.append([row,j])
                break
            } else if board.isOccupied(col: j, row: row){
                break
            }
            availableTiles.append([row,j])
        }
        
        i=row
        j=col
        
        while i > 0 {
            i-=1
            if board.isOccupied(col: col, row: i) && board.isEnemy(pieceName: pieceName, col: col, row: i){
                availableTiles.append([i,col])
                break
            } else if board.isOccupied(col: col, row: i){
                break
            }
            availableTiles.append([i,col])
        }
        
        while j > 0 {
            j-=1
            if board.isOccupied(col: j, row: row) && board.isEnemy(pieceName: pieceName, col: j, row: row){
                availableTiles.append([row,j])
                break
            } else if board.isOccupied(col: j, row: row){
                break
            }
            availableTiles.append([row,j])
        }
        
        return availableTiles
    }
    
    static func knight(row: Int, col: Int, pieceName: String, board: BoardNode) -> [[Int]]{
        var availableTiles : [[Int]] = []
        
        if row < 7 && col < 6 {
            if board.isOccupied(col: col+2, row: row+1) && board.isEnemy(pieceName: pieceName, col: col+2, row: row+1){
                availableTiles.append([row+1, col+2])
            } else if !board.isOccupied(col: col+2, row: row+1){
                availableTiles.append([row+1, col+2])
            }
            
        }
        
        if row < 7 && col > 1 {
            if board.isOccupied(col: col-2, row: row+1) && board.isEnemy(pieceName: pieceName, col: col-2, row: row+1){
                availableTiles.append([row+1, col-2])
            } else if !board.isOccupied(col: col-2, row: row+1){
                availableTiles.append([row+1, col-2])
            }
        }
        
        if row > 0 && col > 1 {
            if board.isOccupied(col: col-2, row: row-1) && board.isEnemy(pieceName: pieceName, col: col-2, row: row-1){
                availableTiles.append([row-1, col-2])
            } else if !board.isOccupied(col: col-2, row: row-1) {
                availableTiles.append([row-1, col-2])
            }
        }
        
        if row > 0 && col < 6 {
            if board.isOccupied(col: col+2, row: row-1) && board.isEnemy(pieceName: pieceName, col: col+2, row: row-1){
                availableTiles.append([row-1, col+2])
            } else if !board.isOccupied(col: col+2, row: row-1){
                availableTiles.append([row-1, col+2])
            }
        }
        
        if row < 6 && col < 7 {
            if board.isOccupied(col: col+1, row: row+2) && board.isEnemy(pieceName: pieceName, col: col+1, row: row+2){
                availableTiles.append([row+2, col+1])
            } else if !board.isOccupied(col: col+1, row: row+2){
                availableTiles.append([row+2, col+1])
            }
        }
        
        if row < 6 && col > 0 {
            if board.isOccupied(col: col-1, row: row+2) && board.isEnemy(pieceName: pieceName, col: col-1, row: row+2){
                availableTiles.append([row+2, col-1])
            } else if !board.isOccupied(col: col-1, row: row+2){
                availableTiles.append([row+2, col-1])
            }
        }
        
        if row > 1 && col > 0 {
            if board.isOccupied(col: col-1, row: row-2) && board.isEnemy(pieceName: pieceName, col: col-1, row: row-2){
                availableTiles.append([row-2, col-1])
            } else if !board.isOccupied(col: col-1, row: row-2){
                availableTiles.append([row-2, col-1])
            }
        }
        
        if row > 1 && col < 7 {
            if board.isOccupied(col: col+1, row: row-2) && board.isEnemy(pieceName: pieceName, col: col+1, row: row-2){
                availableTiles.append([row-2, col+1])
            } else if !board.isOccupied(col: col+1, row: row-2){
                availableTiles.append([row-2, col+1])
            }
        }
        
        return availableTiles
    }
    
    static func queen(row: Int, col: Int, pieceName: String, board: BoardNode) -> [[Int]]{
        var availableTiles: [[Int]] = []
        
        //bishop moves
        var i: Int = row
        var j: Int = col
        
        while i < 7 && j < 7 {
            var accessTile: [Int] = []
            
            accessTile.append(i+1)
            accessTile.append(j+1)
            if board.isOccupied(col: j+1, row: i+1) && board.isEnemy(pieceName: pieceName, col: j+1, row: i+1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j+1, row: i+1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            
            i+=1
            j+=1
        }
        
        i = row
        j = col
        
        while i > 0 && j > 0 {
            var accessTile: [Int] = []
            
            accessTile.append(i-1)
            accessTile.append(j-1)
            
            if board.isOccupied(col: j-1, row: i-1) && board.isEnemy(pieceName: pieceName, col: j-1, row: i-1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j-1, row: i-1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            i-=1
            j-=1
        }
        
        i = row
        j = col
        
        while i > 0 && j < 7 {
            var accessTile: [Int] = []
            
            accessTile.append(i-1)
            accessTile.append(j+1)
            
            if board.isOccupied(col: j+1, row: i-1) && board.isEnemy(pieceName: pieceName, col: j+1, row: i-1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j+1, row: i-1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            i-=1
            j+=1
        }
        
        i = row
        j = col
        
        while i < 7 && j > 0 {
            var accessTile: [Int] = []
            
            accessTile.append(i+1)
            accessTile.append(j-1)
            
            if board.isOccupied(col: j-1, row: i+1) && board.isEnemy(pieceName: pieceName, col: j-1, row: i+1){
                availableTiles.append(accessTile)
                break
            } else if board.isOccupied(col: j-1, row: i+1) {
                break
            } else {
                availableTiles.append(accessTile)
            }
            
            i+=1
            j-=1
        }
        
        //rook moves
        i = row
        j = col
        
        while i < 7 {
            i+=1
            if board.isOccupied(col: col, row: i) && board.isEnemy(pieceName: pieceName, col: col, row: i){
                availableTiles.append([i,col])
                break
            } else if board.isOccupied(col: col, row: i){
                break
            }
            availableTiles.append([i,col])
            
        }
        
        while j < 7 {
            j+=1
            if board.isOccupied(col: j, row: row) && board.isEnemy(pieceName: pieceName, col: j, row: row){
                availableTiles.append([row,j])
                break
            } else if board.isOccupied(col: j, row: row){
                break
            }
            availableTiles.append([row,j])
        }
        
        i=row
        j=col
        
        while i > 0 {
            i-=1
            if board.isOccupied(col: col, row: i) && board.isEnemy(pieceName: pieceName, col: col, row: i){
                availableTiles.append([i,col])
                break
            } else if board.isOccupied(col: col, row: i){
                break
            }
            availableTiles.append([i,col])
        }
        
        while j > 0 {
            j-=1
            if board.isOccupied(col: j, row: row) && board.isEnemy(pieceName: pieceName, col: j, row: row){
                availableTiles.append([row,j])
                break
            } else if board.isOccupied(col: j, row: row){
                break
            }
            availableTiles.append([row,j])
        }
        
        return availableTiles;
    }
    
    
    static func king(row: Int, col: Int, pieceName: String, board: BoardNode)->[[Int]]{
        var avaliableTiles: [[Int]] = []
        
        if col < 7{
            if board.isOccupied(col: col+1, row: row) && board.isEnemy(pieceName: pieceName, col: col+1, row: row){
                avaliableTiles.append([row, col+1])
            } else if !board.isOccupied(col: col+1, row: row){
                avaliableTiles.append([row, col+1])
            }
            
        }
        
        if row < 7 {
            if board.isOccupied(col: col, row: row+1) && board.isEnemy(pieceName: pieceName, col: col, row: row+1){
                avaliableTiles.append([row+1, col])
            } else if !board.isOccupied(col: col, row: row+1){
                avaliableTiles.append([row+1, col])
            }
        }
        
        if row > 0 {
            if board.isOccupied(col: col, row: row-1) && board.isEnemy(pieceName: pieceName, col: col, row: row-1){
                avaliableTiles.append([row-1, col])
            } else if !board.isOccupied(col: col, row: row-1){
                avaliableTiles.append([row-1, col])
            }
        }
        
        if col > 0 {
            if board.isOccupied(col: col-1, row: row) && board.isEnemy(pieceName: pieceName, col: col-1, row: row){
                avaliableTiles.append([row, col-1])
            } else if !board.isOccupied(col: col-1, row: row){
                avaliableTiles.append([row, col-1])
            }
        }
        
        if row > 0 && col > 0 {
            if board.isOccupied(col: col-1, row: row-1) && board.isEnemy(pieceName: pieceName, col: col-1, row: row-1){
                avaliableTiles.append([row-1, col-1])
            } else if !board.isOccupied(col: col-1, row: row-1){
                avaliableTiles.append([row-1, col-1])
            }
        }
        
        if row < 7 && col < 7 {
            if board.isOccupied(col: col+1, row: row+1) && board.isEnemy(pieceName: pieceName, col: col+1, row: row+1){
                avaliableTiles.append([row+1, col+1])
            } else if !board.isOccupied(col: col+1, row: row+1){
                avaliableTiles.append([row+1, col+1])
            }
        }
        
        if row < 7 && col > 0 {
            if board.isOccupied(col: col-1, row: row+1) && board.isEnemy(pieceName: pieceName, col: col-1, row: row+1){
                avaliableTiles.append([row+1, col-1])
            } else if !board.isOccupied(col: col-1, row: row+1){
                avaliableTiles.append([row+1, col-1])
            }
        }
        
        if row > 0 && col < 7 {
            if board.isOccupied(col: col+1, row: row-1) && board.isEnemy(pieceName: pieceName, col: col+1, row: row-1){
                avaliableTiles.append([row-1, col+1])
            } else if !board.isOccupied(col: col+1, row: row-1){
                avaliableTiles.append([row-1, col+1])
            }
        }
        
        return avaliableTiles
    }
}
