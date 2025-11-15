//
//  GameViewController.swift
//  Chess
//
//  Created by Bilolbek Rayimov on 07/11/25.
//

import UIKit
import SpriteKit
import GameplayKit
import SwiftUI

class GameViewController: UIViewController {

    /*override func viewDidLoad() {
        super.viewDidLoad()
            if let view = self.view as! SKView? {
                let scene = GameScene(size: view.bounds.size)   // programmatic size
                scene.scaleMode = .resizeFill                   // match view exactly
                view.presentScene(scene)
                view.ignoresSiblingOrder = true
            }
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Choose what SwiftUI root you want:
        // let rootView = HomeView()         // just the home page
        let rootView = RootTabView()        // if you made a TabView with Home + Play

        let hostingController = UIHostingController(rootView: rootView)

        addChild(hostingController)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
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
