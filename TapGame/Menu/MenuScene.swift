//
//  MenuScene.swift
//  TapGame
//
//  Created by Dmitriy Kirakosyan on 15/11/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import SpriteKit

class MenuScene: SKScene {

    var population: ObjectPopulation?

    override func didMove(to view: SKView) {
        
        Utils.setupBackgroundOnSKScene(scene: self)
        
        
    }
    
    func stopAnimation() {
        population?.stop()
        population = nil
    }
    
    func startAnimation() {
        
        if population == nil {
            population = ObjectPopulation(container: self)
            population!.run()
        }
        
//        population!.delegate = self
    }
    
    

}
