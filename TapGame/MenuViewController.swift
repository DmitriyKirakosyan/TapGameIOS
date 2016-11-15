//
//  MenuViewController.swift
//  TapGame
//
//  Created by Dmitriy on 1/31/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "backTile")!);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playButton.titleLabel!.font = playButton.titleLabel!.font.withSize(playButton.frame.size.height / 2.2)
    }
    
    override func viewDidLayoutSubviews() {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindFromViewController(_ segue: UIStoryboardSegue) {
//        AdManager.instance.updateInterstitialAd()
    }


}
