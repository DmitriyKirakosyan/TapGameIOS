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

        self.loadInterstitialAd()
    }
    
    override func viewDidLayoutSubviews() {
        self.scoreLabel.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height)
        self.scoreTitleLabel.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height)
        self.bestScoreLabel.font = self.bestScoreLabel.font.withSize(self.bestScoreLabel.frame.size.height)
        self.playAgainButton.titleLabel!.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height-10)
        self.menuButton.titleLabel!.font = self.scoreLabel.font.withSize(self.scoreLabel.frame.size.height-10)
        
        let defaults = UserDefaults.standard
        bestScoreLabel.text = String(defaults.integer(forKey: "bestScore"))
    }
    
    func loadInterstitialAd() {
        if let interstitial = AdManager.instance.getInterstitialAd() {
            interstitial.present(fromRootViewController: self)
        }
    }

    
    @IBAction func menuBtnPressed() {
        AdManager.instance.updateInterstitialAd()
        
        delegate?.userWantsGoToMenu()
    }
    
    @IBAction func againBtnPressed() {
        AdManager.instance.updateInterstitialAd()

        delegate?.userWantsPlayAgain()
    }
    
}
