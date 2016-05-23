//
//  Settings.swift
//  TapGame
//
//  Created by Dmitriy on 2/1/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import Foundation

class Settings {
    static var jsonResult: NSDictionary!
    static var soundVolume: Float {
        get {
            if let result = jsonResult.objectForKey("sound_volume") as? Float {
                return result;
            }
            return 0
        }
    }
    static var objectSpeedMin: Float {
        get {
            if let result = jsonResult.objectForKey("object_speed_min") as? Float {
                return result;
            }
            return 0
        }
    }
    static var objectSpeedMax: Float {
        get {
            if let result = jsonResult.objectForKey("object_speed_max") as? Float {
                return result;
            }
            return 0
        }
    }
    static var objectSpeedIncreasing: Float {
        get {
            if let result = jsonResult.objectForKey("object_speed_increasing") as? Float {
                return result;
            }
            return 0
        }
    }
    
    static var maxFails: Int {
        get {
            if let result = jsonResult.objectForKey("max_fails") as? Int {
                return result;
            }
            return 0
        }
    }

    class func load(fileName: String) {
        if let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "json")
        {
            do
            {
                let jsonData = try NSData(contentsOfFile: path, options: NSDataReadingOptions.DataReadingMappedIfSafe)
                
                if let result: NSDictionary = try NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                {
                    jsonResult = result
                }
            }
            catch
            {
                NSLog("ERROR! parcing json file : %@", fileName)
            }
        }
        
    }
}
