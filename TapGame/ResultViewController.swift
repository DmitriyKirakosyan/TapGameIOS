//
//  ResultViewController.swift
//  TapGame
//
//  Created by Dmitriy on 2/3/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import UIKit
import GoogleMobileAds

protocol ResultViewControllerDelegate {
    func userWantsPlayAgain()
    func userWantsGoToMenu()
}

class ResultViewController: UIViewController, GADInterstitialDelegate {

    @IBOutlet weak var bestScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var scoreTitleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    var interstitial: GADInterstitial!
    
    var delegate: ResultViewControllerDelegate?
    
    deinit {
        if DebugSettings.enableDeinitLogs {
            print("Result view controller was deinited")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backTile")!);

        self.loadBanner()
    }
    
    override func viewDidLayoutSubviews() {
        self.scoreLabel.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height)
        self.scoreTitleLabel.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height)
        self.bestScoreLabel.font = self.bestScoreLabel.font.withSize(self.bestScoreLabel.frame.size.height)
        self.playAgainButton.titleLabel!.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height)
        self.menuButton.titleLabel!.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height)
        
        let defaults = UserDefaults.standard
        bestScoreLabel.text = String(defaults.integer(forKey: "bestScore"))
    }
    
    func loadBanner() {
        self.interstitial = GADInterstitial(adUnitID: "ca-app-pub-8795583871628295/5483745960")
        self.interstitial.delegate = self
        let request = GADRequest()
        // Requests test ads on test devices.
        request.testDevices = ["2077ef9a63d2b398840261c8221a0c9b", kGADSimulatorID]
        self.interstitial.load(request)
    }

    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        if self.interstitial.isReady {
            if let viewController =  parent {
                self.interstitial.present(fromRootViewController: viewController)
            }
        }
    }
    
    @IBAction func menuBtnPressed() {
        
        delegate?.userWantsGoToMenu()
    }
    
    @IBAction func againBtnPressed() {
        
        delegate?.userWantsPlayAgain()
    }
    
}
