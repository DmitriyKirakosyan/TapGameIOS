//
//  Utils.swift
//  TapGame
//
//  Created by Dmitriy on 2/2/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import UIKit

class Utils: NSObject {

    class func getOutOfBorderLocation(_ borderSize: CGSize, offset: CGFloat) -> CGPoint {
        var randomX: CGFloat
        var randomY: CGFloat
        
        if (arc4random() % 2 == 1)
        {
            let randomBool: CGFloat = CGFloat( arc4random() % 2 );
            randomX =  randomBool * borderSize.width + randomBool * offset + (randomBool - 1) * offset;
            randomY = CGFloat(Int(arc4random()) % Int(borderSize.height));
        }
        else
        {
            let randomBool: CGFloat = CGFloat( arc4random() % 2 );
            randomY =  randomBool * borderSize.height + randomBool * offset + (randomBool - 1) * offset;
            randomX = CGFloat(Int(arc4random()) % Int(borderSize.width));
        }
        
        return CGPoint(x: randomX, y: randomY)
    }

}
