//
//  GameplaySceneClass.swift
//  DodgingLs
//
//  Created by Elombe Kisala on 1/30/17.
//  Copyright © 2017 Elombe Kisala. All rights reserved.
//

import SpriteKit
import UIKit
import AVFoundation

class GameplaySceneClass: SKScene, SKPhysicsContactDelegate {
    
    private var player: Player?;
    
    private var center = CGFloat();
    
    private var canMove = false, moveLeft = false;
    
    private var itemController = ItemController();
    
    private var scoreLabel: SKLabelNode?;
    
    private var score = 0;
    
    private var highscoreLabel: SKLabelNode?;
    
    private var highscore = 0;
    
    var skyBackground = SKSpriteNode(imageNamed: "BG Sky")
    
    var coinAudioURL = URL(fileURLWithPath: Bundle.main.path(forResource: "CoinDing", ofType: "wav")!);
    
    var coinAudioPlayer = AVAudioPlayer();
    
    var lHitAudioURL = URL(fileURLWithPath: Bundle.main.path(forResource: "GotHit", ofType: "wav")!);
    
    var lHitAudioPlayer = AVAudioPlayer();
    
    override func didMove(to view: SKView) {
        
        //Scene
        
        
        skyBackground.size = self.frame.size;
        skyBackground.zPosition = 0
        
        
        initializeGame();
        
        
        lHitAudioPlayer = try! AVAudioPlayer(contentsOf: lHitAudioURL, fileTypeHint: nil);
        
        coinAudioPlayer = try! AVAudioPlayer(contentsOf: coinAudioURL, fileTypeHint: nil);
        
        // Allow Background Music
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
        
        
        let highscoreDefault = UserDefaults.standard;
        
        if (highscoreDefault.value(forKey: "highscore") != nil ) {
        
            highscore = highscoreDefault.value(forKey: "highscore") as! NSInteger!
            
            highscoreLabel?.text = NSString(format: "%i", highscore) as String;
        }
        
        self.addChild(skyBackground)
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        managePlayer();
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in:self);
            
            if location.x > center {
                
                moveLeft = false;
                
            } else {
                
                moveLeft = true;
                
            }
            
        }
        
        canMove = true;
        
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        canMove = false;
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = SKPhysicsBody();
        var secondBody = SKPhysicsBody();
        
        if contact.bodyA.node?.name == "Player" {
            
            firstBody = contact.bodyA;
            secondBody = contact.bodyB;
            
        } else {
            
            firstBody = contact.bodyB;
            secondBody = contact.bodyA;
            
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "Coin" {
            
            
            score += 1;
            scoreLabel?.text = NSString(format: "%i", score) as String
            
            
            if score > highscore {
                
                highscore = score
                
                highscoreLabel?.text = NSString(format: "%i", highscore) as String
                
                let highscoreDefault = UserDefaults.standard;
                
                highscoreDefault.setValue(highscore, forKey: "highscore")
                
                highscoreDefault.synchronize()
            

            }
            
            coinAudioPlayer.play();
            
            secondBody.node?.removeFromParent();
                        
            
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "L" {
            
            
            firstBody.node?.removeFromParent();
            secondBody.node?.removeFromParent();
            
            Timer.scheduledTimer(timeInterval: (0.1), target: self, selector: #selector(GameplaySceneClass.restartGame), userInfo: nil, repeats: false);
            
            
        }
        
    }
    
    private func initializeGame() {
        
        physicsWorld.contactDelegate = self;
        
        player = childNode(withName: "Player") as? Player!;
        
        player?.initializePlayer();
        
        scoreLabel = childNode(withName: "ScoreLabel") as? SKLabelNode;
        
        scoreLabel?.text = "0";
        
        highscoreLabel = childNode(withName: "HighscoreLabel") as? SKLabelNode;
        
        highscoreLabel?.text = "0";
        
        center = self.frame.size.width / self.frame.size.height;
        
        Timer.scheduledTimer(timeInterval: TimeInterval(itemController.randomBetweenNumbers(firstNum: 0.4, secondNum: 0.8)), target: self, selector: #selector(GameplaySceneClass.spawnItems), userInfo: nil, repeats: true)
        
        Timer.scheduledTimer(timeInterval: TimeInterval(4), target: self, selector: #selector(GameplaySceneClass.removeItems), userInfo: nil, repeats: true);
        
    }
    
    private func managePlayer() {
        
        if canMove {
            
            player?.move(left: moveLeft);
            
        }
        
    }
    
    func spawnItems() {
        
        self.scene?.addChild(itemController.spawnItems(scene: self));
        
    }
    
    func restartGame() {
        
        if let scene = MainMenuScene(fileNamed: "MainMenu") {
            
             lHitAudioPlayer.play();
            
            scene.scaleMode = .aspectFill
            view?.presentScene(scene, transition: SKTransition.fade(with: UIColor.white, duration: (1.25)))
            
        }
        
    }
    
    func removeItems() {
        
        for child in children {
            
            if child.name == "Coin" || child.name == "L" {
                
                if child.position.y < -self.frame.height - 100 {
                    
                    child.removeFromParent();
                    
                }
                
            }
            
            
        }
        
    }
    
    
    
}



















