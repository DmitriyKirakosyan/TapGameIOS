//
//  GameViewController.swift
//  TapGame
//
//  Created by Dmitriy on 1/31/16.
//  Copyright (c) 2016 Dmitriy. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameSceneDelegate, ResultViewControllerDelegate {
    
    private var gameScene: GameScene?
    private var resultController: ResultViewController?
    
    deinit {
        if DebugSettings.enableDeinitLogs {
            print("game view controller was deinited")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameScene = GameScene(fileNamed:"GameScene")
        if let scene = gameScene {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
//            SKColor(patternImage: UIImage(named: "backTile")!)
//            scene.backgroundColor = SKColor(patternImage: UIImage(named: "backTile")!);
            
            skView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
//        (self.view as! SKView).presentScene(gameScene)
        gameScene?.gameDelegate = self
        gameScene?.startGame()
    }
    
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    //MARK: - GameSceneDelegate
    
    func gameOver(score: Int) {
        let defaults = NSUserDefaults.standardUserDefaults()
        let bestScore = defaults.integerForKey("bestScore")
        if score > bestScore {
            defaults.setInteger(score, forKey: "bestScore")
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        resultController = storyboard.instantiateViewControllerWithIdentifier("ResultViewController") as? ResultViewController;
        resultController!.delegate = self
        
        self.view.addSubview(resultController!.view)

        resultController?.scoreLabel.text = "\(score)"
        resultController?.bestScoreLabel.text = "\(bestScore)"
    }
    
    //MARK: - ResultViewControllerDelegate
    
    func userWantsPlayAgain() {
        dismissResultController()
        gameScene?.startGame()
    }
    
    func userWantsGoToMenu() {
        dismissResultController()

        gameScene = nil
        (self.view as! SKView).presentScene(nil)
        
        navigationController?.popToRootViewControllerAnimated(true)
    }
    
    private func dismissResultController() {
        resultController?.view.removeFromSuperview()
        resultController?.delegate = nil
        resultController = nil
    }
}
