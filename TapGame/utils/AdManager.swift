//
//  AdManager.swift
//  ParrotRider
//
//  Created by Dmitriy Kirakosyan on 1/11/16.
//  Copyright © 2016 Frederick Siu. All rights reserved.
//

import Foundation
import GoogleMobileAds

class AdManager {
    
    static let instance = AdManager()
    
    private let GamesBeforeIntersitial = 3
    private var gamesBeforeIntersitialPlayed = 0
    
    private var interstitial: GADInterstitial!
    
    static let ApplicationID = "ca-app-pub-8795583871628295~7100079968"
//    static let InterstitialID = "ca-app-pub-8795583871628295/5483745960"
    static let InterstitialID = "ca-app-pub-3940256099942544/4411468910" // test interstitial
//    static let BannerID = "ca-app-pub-5791334862637114/5111461788"
    
    static let testDevices: [Any] = [kGADSimulatorID, "e2abaacc2147b06eff60df3f20e02649"]
    
    
    private(set) var isEnabled = false
    
    private init() {
        UserDefaults.standard.register(defaults: ["adEnabled": true])
        isEnabled = UserDefaults.standard.bool(forKey: "adEnabled")
    }
    
    func disableAds() {
        isEnabled = false
        UserDefaults.standard.set(false, forKey: "adEnabled")
        
        interstitial = nil
    }
    
    func configure() {
        guard isEnabled else { return }
        
        GADMobileAds.configure(withApplicationID: AdManager.ApplicationID)
        interstitial = createInterstitial()
    }
    
    func getInterstitialAd() -> GADInterstitial? {
        guard isEnabled else { return nil}

        gamesBeforeIntersitialPlayed += 1

        guard interstitial != nil && interstitial.isReady else { return nil }
        
        if gamesBeforeIntersitialPlayed > GamesBeforeIntersitial {
            gamesBeforeIntersitialPlayed = 0
            let result = interstitial
            interstitial = nil
            return result
        }

        return nil
    }
    
    func updateInterstitialAd() {
        // create new interstitial to give it a break to be ready for next time
        if interstitial == nil {
            interstitial = createInterstitial()
        }
    }
    
//    func getBannerOn(viewController: UIViewController) {
//        guard self.isEnabled else { return }
//        
//        let bannerView = createBanner()
//        bannerView.removeFromSuperview()
//        bannerView.rootViewController = viewController
//        viewController.view.addSubview(bannerView)
//        bannerView.translatesAutoresizingMaskIntoConstraints = false
//        viewController.view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .bottom,
//                                              relatedBy: .equal, toItem: viewController.view, attribute: .bottom, multiplier: 1, constant: 0))
//        viewController.view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .centerX,
//                                              relatedBy: .equal, toItem: viewController.view, attribute: .centerX, multiplier: 1, constant: 0))
//        
//        
//        let request = GADRequest()
//        request.testDevices = AdManager.testDevices
//        bannerView.load(request)
//    }
    
    
    private func createInterstitial() -> GADInterstitial {
        let result = GADInterstitial(adUnitID: AdManager.InterstitialID)
        
        let request = GADRequest()
        request.testDevices = AdManager.testDevices
        result.load(request)
        return result
    }
}
