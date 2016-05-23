//
//  TapTargetBehavior.swift
//  TapGame
//
//  Created by Dmitriy on 2/2/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import SpriteKit


protocol TTBehaviorDelegate {
    func objectLeft(behaviour: TapTargetBehavior)
}

class TapTargetBehavior: NSObject {
    var screenSize: CGSize
    var tapTarget: TapTarget?
    var moveAction: SKAction?
    var speed: Float
    var isActing: Bool
    
    var delegate: TTBehaviorDelegate?
    
    deinit {
        if DebugSettings.enableDeinitLogs {
            print("object behavior is deinited")
        }
    }
    
    init(screenSize: CGSize, speed: Float) {
        self.screenSize = screenSize
        self.speed = speed;
        self.isActing = false
    }
    
    func destroy() {
        self.isActing = false
        if let target = tapTarget {
            target.removeAllActions()
            tapTarget = nil;
        }
    }

    func act(tapTarget: TapTarget) {
        self.isActing = true
        self.tapTarget = tapTarget
        self.tapTarget?.removeAllActions()
        self.tapTarget?.startAnimating()
        self.flySomewhere(true)
    }
    
    //Private methods
    
    
    func flySomewhere(firstLaunch: Bool = false) {
        if let target = tapTarget {
            target.removeActionForKey("moveAction")
            
            
            let goForDeath = random() % 2 == 1 && !firstLaunch
            let pointToFly = goForDeath ?
                Utils.getOutOfBorderLocation(screenSize, offset: target.size.width * 2) :
                self.getPointToFly(firstLaunch)
            
            let completion = goForDeath ?
                SKAction.runBlock {
                    [weak self] in
                    if self != nil && self!.isActing { self!.delegate?.objectLeft(self!) }
                }
                :
                SKAction.runBlock {
                    [weak self] in
                    if self != nil && self!.isActing { self!.flySomewhere() }
                }

                //rotation
                target.zRotation = self.getRotationToPoint(pointToFly)
                
                //moving
                moveAction = SKAction.moveTo(pointToFly, duration: NSTimeInterval(self.getDurationToPoint(pointToFly)))
                moveAction = SKAction.sequence([moveAction!, completion])
                target.runAction(moveAction!, withKey: "moveAction")
        }
    }
    
    
    func getPointToFly() -> CGPoint {
        return self.getPointToFly(false)
    }
    func getPointToFly(longDistance: Bool) -> CGPoint {
        var result = CGPoint(x: random() % Int(screenSize.width), y: random() % Int(screenSize.height))
        if tapTarget != nil && longDistance {
            if distance(tapTarget!.position, p2: result) < screenSize.width / 1.2 {
                result = getPointToFly(true)
            }
        }
        return result
    }
    
    func getRotationToPoint(point: CGPoint) -> CGFloat {
        if let target = tapTarget {
            let dx = target.position.x - point.x;
            let dy = target.position.y - point.y;
            let angle = atan2(dy, dx) + CGFloat(M_PI_2);
            return angle
        }
        return 0
    }
    
    func getDurationToPoint(point: CGPoint) -> CGFloat {
        let basicSpeed = CGFloat(1 / speed) / screenSize.width
        if let target = tapTarget {
            return basicSpeed * self.distance(target.position, p2: point)
        }
        return 0
    }
    
    func distance(p1: CGPoint, p2: CGPoint) -> CGFloat {
        return hypot(p1.x - p2.x, p1.y - p2.y);
    }
}
