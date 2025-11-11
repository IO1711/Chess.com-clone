//
//  GameViewController.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 07/11/25.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            if let view = self.view as! SKView? {
                let scene = GameScene(size: view.bounds.size)   // programmatic size
                scene.scaleMode = .resizeFill                   // match view exactly
                view.presentScene(scene)
                view.ignoresSiblingOrder = true
            }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
