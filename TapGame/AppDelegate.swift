//
//  AppDelegate.swift
//  TapGame
//
//  Created by Dmitriy on 1/31/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import UIKit
import Parse
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Settings.load("settings")
        
        FIRApp.configure()
        
        AdManager.instance.configure()
        
        
        
        initParse()
        
        loginUser()
        
        registerForParseNotifications()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    //MARK: - Private
    
    private func initParse() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "hXmcNGDrjXWek1v4jhq4IizDQP8Q9gURQ66VUeMO"
            $0.clientKey = "MxOzPANTZHX9qXG5V2QRRArxagMd6QRPUk6UOA8U"
            $0.server = "https://pg-app-1fi1au5pk82nalygdyxx613ewerehx.scalabl.cloud/1/"
        }
        Parse.initialize(with: configuration)
    }
    
    private func loginUser() {
        guard PFUser.current() == nil else { return }
        
        let user = PFUser()
        user.username = "her"
        user.password = "her"
        user.setValue("her v palto", forKey: "her_wearing")
        
        
        user.signUpInBackground { (success, error) -> () in
            if !success {
                //try login
                
                PFUser.logInWithUsername(inBackground: user.username!, password: user.password!) { (user, error) in
                    if let user = user {
                        print("User logged in : \(user)")
                    } else {
                        print("There is a problem with loggin in user 'her' : \(error)")
                    }
                }
            } else {
                print("User singed up")
            }
        }
    }

    //MARK: Notifications
    
    func registerForParseNotifications() {
        if PFUser.current() != nil {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }


    func application(_ application: UIApplication, didRegister notificationSettings: UIUserNotificationSettings) {
        print("[AppDelegate] app did register for notification settings")
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("[AppDelegate] app did register for remote notifications")
        if let userObjectId = PFUser.current()?.objectId, let installation = PFInstallation.current() {
            
            installation.setDeviceTokenFrom(deviceToken)
            installation.channels = ["global", "user_\(userObjectId)"]
            installation.setValue(userObjectId, forKey: "userId")
            installation.setValue(true, forKey: "receiveMessages")
            installation.setValue(true, forKey: "receiveActivities")
            installation.saveInBackground { (succeeded, error) -> () in
                if succeeded {
                    print("Succeeded saving push data in installation")
                } else {
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("[Push received. Object : \(userInfo)")
    }
}

