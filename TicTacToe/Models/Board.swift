//
//  Board.swift
//  TicTacToe
//
//  Created by Jon Corn on 2/12/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import GameplayKit

class Board: NSObject {
    var currentPlayer = Player.allPlayers[arc4random() % 2 == 0 ? 0 : 1]
    
    fileprivate var values: [[Player.Value]] = [[.empty, .empty, .empty], [.empty, .empty, .empty], [.empty, .empty, .empty]]
    
    subscript(x: Int, y: Int) -> Player.Value {
        get {
            return values[y][x]
        }
        set {
            if values[y][x] == .empty {
                values[y][x] = newValue
            }
        }
    }
    
    var isFull: Bool {
        for row in values {
            for tile in row {
                if tile == .empty {
                    return false
                }
            }
        }
        return true
    }
    
    var winningPlayer: Player? {
        for column in 0..<values.count {
            if values[column][0] == values[column][1] && values[column][0] == values[column][2] && values[column][0] != .empty {
                if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
                    return player.value == values[column][0]
                }) {
                    return Player.allPlayers[index]
                } else {
                    return nil
                }
            } else if values[0][column] == values[1][column] && values[0][column] == values[2][column] && values[0][column] != .empty {
                if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
                    return player.value == values[0][column]
                }){
                    return Player.allPlayers[index]
                } else {
                    return nil
                }
            }
        }
        
        if values[0][0] == values[1][1] && values[0][0] == values[2][2] && values[0][0] != .empty {
            if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
                return player.value == values[0][0]
            }){
                return Player.allPlayers[index]
            } else {
                return nil
            }
        } else if values[2][0] == values[1][1] && values[2][0] == values[0][2] && values[0][2] != .empty {
            if let index = Player.allPlayers.firstIndex(where: { player -> Bool in
                return player.value == values[2][0]
            }){
                return Player.allPlayers[index]
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    func clear() {
        for x in 0..<values.count {
            for y in 0..<values[x].count {
                self[x, y] = .empty
            }
        }
    }
    
    func canMove(at position: CGPoint) -> Bool {
        if self[Int(position.x), Int(position.y)] == .empty {
            return true
        } else {
            return false
        }
    }
}

// MARK: - Extensions
extension Board: GKGameModel {
    
    /// Needs these two functions to conform to GKGameModel
    func gameModelUpdates(for player: GKGameModelPlayer) -> [GKGameModelUpdate]? {
        
        /// 1 Tells gameplayKit about all the possible moves in the current state of the game
        guard let player = player as? Player else {
            return nil
        }
        
        if isWin(for: player) {
            return nil
        }
        
        var moves = [Move]()
        
        /// 2 Loop over all the board's positions and add a position to the possible moves array if it not already occupied
        for x in 0..<values.count {
            for y in 0..<values[x].count {
                let position = CGPoint(x: x, y: y)
                if canMove(at: position) {
                    moves.append(Move(coordinate: position))
                }
            }
        }
        return moves
    }
    
    func apply(_ gameModelUpdate: GKGameModelUpdate) {
        guard let move = gameModelUpdate as? Move else {
            return
        }
        
        /// `apply` gets called after each move selected by the strategist so you have the chance to update the game state.
        self[Int(move.coordinate.x), Int(move.coordinate.y)] = currentPlayer.value
        currentPlayer = currentPlayer.opponent
    }
    
    
    func copy(with zone: NSZone? = nil) -> Any {
        let copy = Board()
        copy.setGameModel(self)
        return copy
    }
    
    var players: [GKGameModelPlayer]? {
        return Player.allPlayers
    }
    
    var activePlayer: GKGameModelPlayer? {
        return currentPlayer
    }
    
    func setGameModel(_ gameModel: GKGameModel) {
        if let board = gameModel as? Board {
            values = board.values
        }
    }
    
    /// Determines whether a player wins the game via `winningPlayer` by looping thru the board to fidn whether either player has won, returning the player if so.
    func isWin(for player: GKGameModelPlayer) -> Bool {
        guard let player = player as? Player else {
            return false
        }
        if let winner = winningPlayer {
            return player == winner
        } else {
            return false
        }
    }
    
    /// AI will use this func to calculate it's best move. GameplayKit will create the moves, and will use the shortest path to victory
    func score(for player: GKGameModelPlayer) -> Int {
        guard let player = player as? Player else {
            return Move.Score.none.rawValue
        }
        if isWin(for: player) {
            return Move.Score.win.rawValue
        } else {
            return Move.Score.none.rawValue
        }
    }
}
