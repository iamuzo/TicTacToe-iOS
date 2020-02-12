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
        
        strategist.maxLookAheadDepth = 5
        strategist.randomSource = GKARC4RandomSource()
        
        return strategist
    }()
    
    var board: Board {
        didSet {
            strategist.gameModel = board as? GKGameModel
        }
    }
    
    var bestCoordinate: CGPoint? {
        if let move = strategist.bestMove(for: board.currentPlayer) as?
            Move {
            return move.coordinate
        }
        
        return nil
    }
}
