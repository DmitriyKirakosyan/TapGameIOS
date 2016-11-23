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
    
    fileprivate var gameScene: GameScene?
    fileprivate var resultController: ResultViewController?
    
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
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
//            SKColor(patternImage: UIImage(named: "backTile")!)
//            scene.backgroundColor = SKColor(patternImage: UIImage(named: "backTile")!);
            
            skView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        (self.view as! SKView).presentScene(gameScene)
        gameScene?.gameDelegate = self
        gameScene?.startGame()
    }
    
    
    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    //MARK: - GameSceneDelegate
    
    func gameOver(_ score: Int) {
        let defaults = UserDefaults.standard
        let bestScore = defaults.integer(forKey: "bestScore")
        if score > bestScore {
            defaults.set(score, forKey: "bestScore")
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        resultController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController;
        resultController!.delegate = self
        
        self.addChildViewController(resultController!)
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
        
        _ = navigationController?.popToRootViewController(animated: true)
    }
    
    fileprivate func dismissResultController() {
        resultController?.view.removeFromSuperview()
        resultController?.removeFromParentViewController()
        resultController?.delegate = nil
        resultController = nil
    }
}
