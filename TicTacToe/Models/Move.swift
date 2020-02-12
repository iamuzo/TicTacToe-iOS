//
//  Move.swift
//  TicTacToe
//
//  Created by Jon Corn on 2/12/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import GameplayKit

class Move: NSObject, GKGameModelUpdate {
    
    // MARK: - PROPERTIES
    // This enum defines the "score" of a move based on whether it results in a win
    enum Score: Int {
        case none
        case win
    }
    // Providing a value property to help keep score of each move
    var value: Int = 0
    var coordinate: CGPoint
    
    // INITIALIZER
    init(coordinate: CGPoint) {
        self.coordinate = coordinate
    }
}
