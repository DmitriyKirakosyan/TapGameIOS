//
//  MenuViewController.swift
//  TapGame
//
//  Created by Dmitriy on 1/31/16.
//  Copyright © 2016 Dmitriy. All rights reserved.
//

import SpriteKit

class MenuViewController: UIViewController {
    
    private var scene: MenuScene?

    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundView.isHidden = true
        
        presentScene()
//        backgroundView.backgroundColor = UIColor(patternImage: UIImage(named: "backTile")!);
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playButton.titleLabel!.font = playButton.titleLabel!.font.withSize(playButton.frame.size.height / 2.2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        scene?.startAnimation()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        scene?.stopAnimation()
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

    
    private func presentScene() {
        
//        let sceneWidth = (self.view as! SKView).bounds.width
//        let sceneHeight = self.view.bounds.height - playButton.frame.origin.y - playButton.frame.size.height
        
        scene = MenuScene(size: self.view.bounds.size)
        if let scene = scene {
            // Configure the view.
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            //            SKColor(patternImage: UIImage(named: "backTile")!)
            //            scene.backgroundColor = SKColor(patternImage: UIImage(named: "backTile")!);
            
            skView.presentScene(scene)
        }

    }

}
