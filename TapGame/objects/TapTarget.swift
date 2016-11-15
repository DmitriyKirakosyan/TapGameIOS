//
//  TapTarget.swift
//  TapGame
//
//  Created by Dmitriy on 1/31/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import SpriteKit

class TapTarget: SKSpriteNode {
    
    var frames: [String]!
    var animation: SKAction!
    
    var _deathTextures = ["deadTarget1", "deadTarget2", "deadTarget3"]

    class func tapTarget() -> TapTarget {
        return TapTarget()
    }
    
    deinit {
        if DebugSettings.enableDeinitLogs {
            print("tap target is deinited")
        }
    }
    
    init() {
        let texture = SKTexture(imageNamed: "tapTarget001")
        super.init(texture: texture, color: UIColor.clear, size: texture.size())
        
        // animation textures
        var textures: [SKTexture] = [];
        for i in 0..<3 {
            let textureName = String(format: "tapTarget%03d", i+1)
            let temp: SKTexture =  SKTexture(imageNamed: textureName)
            textures.append(temp);
        }
        
        animation = SKAction.sequence([
            SKAction.animate(with: textures, timePerFrame: 0.03)
            ])
        animation = SKAction.repeatForever(animation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimating() {
        self.run(animation, withKey: "animating")
    }
    
    func stopAnimating() {
        self.removeAction(forKey: "animating")
    }
    
    func setTapped() {
        let index = Int(arc4random()) % _deathTextures.count
        let deathTexture = SKTexture(imageNamed: _deathTextures[index])
        self.texture = deathTexture
    }

}
