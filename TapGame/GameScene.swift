//
//  GameScene.swift
//  TapGame
//
//  Created by Dmitriy on 1/31/16.
//  Copyright (c) 2016 Dmitriy. All rights reserved.
//

import SpriteKit
import GoogleMobileAds

protocol GameSceneDelegate {
    func gameOver(score: Int)
}

class GameScene: SKScene, ObjectPopulationDelegate {
    
    var scoreLabel: SKLabelNode!;
    var score: Int = 0;
    var remainingFails: Int = 0;
    
    var population: ObjectPopulation!
    
    var gameDelegate: GameSceneDelegate?
    
    deinit {
        if DebugSettings.enableDeinitLogs {
            print("game scene was deinited")
        }
    }
    
    override func didMoveToView(view: SKView) {
        // to make the scene size be actual
        self.size = self.view!.frame.size;
        
        self.setupBackground()
        
        scoreLabel = SKLabelNode(fontNamed:"Chalkduster")
        scoreLabel.fontSize = 30
        scoreLabel.position = CGPoint(x:self.size.width/2, y:self.size.height - 50)

        self.addChild(scoreLabel)
        
    }
    
    func startGame() {
        if population != nil {
            print("ERROR! trying to start already running game")
            return
        }
        
        remainingFails = Settings.maxFails
        score = 0
        
        displayScore()
        
        population = ObjectPopulation(container: self)
        population.delegate = self
        population.run()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            self.increaseScoreFor(population.tryKillSome(location))
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func increaseScoreFor(scoreAmount: Int) {
        score += scoreAmount
        
        displayScore()
    }
    
    func displayScore() {
        scoreLabel.text = "Score : " + String(score)
    }
    
    // ObjectPopulationDelegate
    
    func objectWasLost() {
        remainingFails -= 1
        if remainingFails <= 0 {
            destroyScene()
            
            gameDelegate?.gameOver(score)

        }
    }
    
    
    private func destroyScene() {
        population.stop()
        population.delegate = nil
        population = nil
    }
    
    private func setupBackground() {
        var totW: CGFloat = 0;
        var totH: CGFloat = 0;
        var i = 0;
        var j = 0;
        let tile = SKTexture(image: UIImage(named: "backTile")!)
        
        while (totH < self.size.height) {
            
            while (totW < self.size.width) {
                let bg = SKSpriteNode(texture: tile);
                bg.zPosition = -100
                let xPosition = CGFloat(i) * tile.size().width + tile.size().width/2
                let yPosition = CGFloat(j) * tile.size().height + tile.size().height/2
                
                bg.position = CGPointMake(xPosition, yPosition);
                
                self.addChild(bg)
                i += 1
                totW += tile.size().width;
            }
            j += 1
            totH += tile.size().height;
            
            i = 0; totW = 0;
        }
    }
}
