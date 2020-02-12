//
//  Strategist.swift
//  TicTacToe
//
//  Created by Jon Corn on 2/12/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import GameplayKit

struct Strategist {
    
    private let strategist: GKMinmaxStrategist = {
       let strategist = GKMinmaxStrategist()
        
        /**constraints given to strategist to limit the number of moves it can stimulate*/
        strategist.maxLookAheadDepth = 5
        strategist.randomSource = GKARC4RandomSource()
        
        return strategist
    }()
    
    /**keep reference to game model and supply that to strategist*/
    var board: Board {
        didSet {
            strategist.gameModel = board
        }
    }
    
    /**the best coordinate is a CGPoint representing the strategist's best move*/
    var bestCoordinate: CGPoint? {
        /**returns nil if the play is in aninvalid state or nonexistent*/
        if let move = strategist.bestMove(for: board.currentPlayer) as?
            Move {
            return move.coordinate
        }
        
        return nil
    }
}
