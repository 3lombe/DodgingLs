//
//  GameViewController.swift
//  DodgingLs
//
//  Created by Elombe Kisala on 1/30/17.
//  Copyright © 2017 Elombe Kisala. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import GoogleMobileAds



class GameViewController: UIViewController, GADBannerViewDelegate {
    
    @IBOutlet var bannerView: GADBannerView!
    
    //var min = 4
    
    //var tryAgain = 10

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.delegate = self
        bannerView.adUnitID = "ca-app-pub-2382471766301173/9037935240"
        bannerView.rootViewController = self
        bannerView.load(request);
        
        
        if let view = self.view as! SKView? {
            
            // Load the SKScene from 'GameScene.sks'
            if let scene = MainMenuScene(fileNamed: "MainMenu") {
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false;
            view.showsNodeCount = false;
            view.showsPhysics = false;
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    /*
    //Rate My App
    override func viewDidAppear(_ animated: Bool) {
        runAlert()
    }
    
    func runAlert() {
        
        let neverShow = UserDefaults.standard.bool(forKey: "neverShow")
        
        print(neverShow)
        
        var numLaunch = UserDefaults.standard.integer(forKey: "numLaunch") + 1
        
        if !neverShow && numLaunch == min || numLaunch >= (min + tryAgain + 1) {
            
            showRateMe()
            
            numLaunch = min + 1
            
        }
        
        UserDefaults.standard.set(numLaunch, forKey: "numLaunch")
        
    }
    
    func showRateMe() {
        
        let alert = UIAlertController(title: "Having Fun?", message: "Thanks for playing Dodging L's", preferredStyle: UIAlertControllerStyle.alert)
        
        let link = URL(string: "itms-apps://itunes.apple.com/app/id1167802160")
        
        let rateAction = UIAlertAction(title: "Rate Us", style: UIAlertActionStyle.default) { (alertAction) in
            
            UIApplication.shared.openURL(link!)
            
        }
        
        let neverAction = UIAlertAction(title: "No Thanks", style: UIAlertActionStyle.default) { (alertAction) in
            
            UserDefaults.standard.set(true, forKey: "neverShow")
            
        }
        
        let maybeAction = UIAlertAction(title: "Maybe Later", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(rateAction)
        
        alert.addAction(neverAction)
        
        alert.addAction(maybeAction)
        
        self.present(alert, animated: true, completion: nil)
        
    }*/
    
    
}
