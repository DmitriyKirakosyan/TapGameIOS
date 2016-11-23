//
//  Utils.swift
//  TapGame
//
//  Created by Dmitriy on 2/2/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import SpriteKit

class Utils: NSObject {

    class func getOutOfBorderLocation(_ borderSize: CGSize, offset: CGFloat) -> CGPoint {
        var randomX: CGFloat
        var randomY: CGFloat
        
        if (arc4random() % 2 == 1)
        {
            let randomBool: CGFloat = CGFloat( arc4random() % 2 );
            randomX =  randomBool * borderSize.width + randomBool * offset + (randomBool - 1) * offset;
            randomY = CGFloat(arc4random() % UInt32(borderSize.height));
        }
        else
        {
            let randomBool: CGFloat = CGFloat( arc4random() % 2 );
            randomY =  randomBool * borderSize.height + randomBool * offset + (randomBool - 1) * offset;
            randomX = CGFloat(arc4random() % UInt32(borderSize.width));
        }
        
        return CGPoint(x: randomX, y: randomY)
    }
    
    
    class func setupBackgroundOnSKScene(scene: SKScene) {
        var totW: CGFloat = 0;
        var totH: CGFloat = 0;
        var i = 0;
        var j = 0;
        let tile = SKTexture(image: UIImage(named: "backTile")!)
        
        while (totH < scene.size.height) {
            
            while (totW < scene.size.width) {
                let bg = SKSpriteNode(texture: tile);
                bg.zPosition = -100
                let xPosition = CGFloat(i) * tile.size().width + tile.size().width/2
                let yPosition = CGFloat(j) * tile.size().height + tile.size().height/2
                
                bg.position = CGPoint(x: xPosition, y: yPosition);
                
                scene.addChild(bg)
                i += 1
                totW += tile.size().width;
            }
            j += 1
            totH += tile.size().height;
            
            i = 0; totW = 0;
        }

    }

}
