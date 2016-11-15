//
//  ObjectPopulation.swift
//  TapGame
//
//  Created by Dmitriy on 2/2/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import SpriteKit

protocol ObjectPopulationDelegate {
    func objectWasLost()
}

class ObjectPopulation: NSObject, TTBehaviorDelegate {
    var scene: SKScene
    var objects: [TapTargetBehavior] = []
    var timer = Timer()
    
    var minSpeed: Float = 0
    var maxSpeed: Float = 0
    var speedIncreaseValue: Float = 0
    var currentSpeed: Float = 0
    
    var delegate: ObjectPopulationDelegate?
    
    deinit {
        if DebugSettings.enableDeinitLogs {
            print("object population is deinited")
        }
    }
    
    init(container: SKScene) {
        scene = container
        
        minSpeed = Settings.objectSpeedMin
        maxSpeed = Settings.objectSpeedMax
        speedIncreaseValue = Settings.objectSpeedIncreasing
        currentSpeed = minSpeed
    }
    
    func run() {
        self.createNewObject()
        self.scheduleTimer()
    }
    
    func stop() {
        timer.invalidate()
        objects.forEach { destroyObject($0, animated: false) }
    }
    
    /// returns number of killed
    func tryKillSome(_ location: CGPoint) -> Int {
        let objectsToKill = objects.filter { $0.tapTarget != nil && $0.tapTarget!.contains(location) }
        
        let result = objectsToKill.count
        
        objectsToKill.forEach { destroyObject($0, animated: true) }

        return result
    }
    
    // Private methods
    
    func scheduleTimer() {
        timer = Timer.scheduledTimer(timeInterval: self.getTimerInterval(), target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    func createNewObject() {
        let object = TapTarget.tapTarget()
        object.size = CGSize(width: 50, height: 50)
        
        object.position = Utils.getOutOfBorderLocation(scene.frame.size, offset: object.size.width * 2)
        let behavior = TapTargetBehavior(screenSize: scene.frame.size, speed: currentSpeed)
        behavior.act(object)
        behavior.delegate = self
        objects.append(behavior)
        
        scene.addChild(object)
    }
    
    
    func timerAction() {
        self.increaseSpeed()
        self.createNewObject()
        self.scheduleTimer()
    }
    
    func getTimerInterval() -> TimeInterval {
        return 1
    }
    
    func removeObjectFromScene(_ object: TapTarget?, animated: Bool) {
        if animated {
            object?.setTapped()
            object?.run(SKAction.fadeAlpha(to: 0, duration: 2), completion: {
                [weak object] in // if we don't use weak here, otherwise we get retain circle
                
                object?.removeFromParent()
            })
        } else {
            object?.removeFromParent()
        }
    }
    
    func destroyObject(_ behavior: TapTargetBehavior, animated: Bool) {
        let tapTarget = behavior.tapTarget
        behavior.delegate = nil
        behavior.destroy()
        objects.remove(at: objects.index(of: behavior)!)

        
        self.removeObjectFromScene(tapTarget, animated: animated)
    }
    
    func increaseSpeed() {
        currentSpeed += speedIncreaseValue
        if currentSpeed > maxSpeed { currentSpeed = maxSpeed }
    }
    
    //MARK: - TTBehaviorDelegate
    
    func objectLeft(_ behaviour: TapTargetBehavior) {
        destroyObject(behaviour, animated: false)
        
        delegate?.objectWasLost()
    }
}
