//
//  GameViewController.swift
//  TicTacToe
//
//  Created by Jon Corn on 2/12/20.
//  Copyright © 2020 Uzo Agu. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as? SKView {
            let scene = GameScene(size: UIScreen.main.bounds.size)
            scene.scaleMode = .aspectFill
            view.presentScene(scene)
        }
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
