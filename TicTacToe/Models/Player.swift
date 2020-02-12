//
//  Player.swift
//  TicTacToe
//
//  Created by Jon Corn on 2/12/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import GameplayKit

class Player: NSObject, GKGameModelPlayer {
    
    // MARK: - PROPERTIES
    enum Value: Int {
        case empty
        case brain
        case zombie
        
        var name: String {
            switch self {
            case .empty:
                return ""
            case .brain:
                return "Brain"
            case .zombie:
                return "Zombie"
            }
        }
    }
    
    var value: Value
    var name: String
    
    // this property allows Player to conform to GKGameModelPlayer
    var playerId: Int
    
    static var allPlayers = [Player(.brain), Player(.zombie)]
    
    var opponent: Player {
        if value == .zombie {
            return Player.allPlayers[0]
        } else {
            return Player.allPlayers[1]
        }
    }
    
    // INITIALIZER
    init(_ value: Value) {
        self.value = value
        self.name = value.name
        self.playerId = value.rawValue
    }
}
