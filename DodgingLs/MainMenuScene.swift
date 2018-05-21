 //
//  MainMenuScene.swift
//  DodgingLs
//
//  Created by Elombe Kisala on 1/30/17.
//  Copyright © 2017 Elombe Kisala. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    
    var skyMenuBackground = SKSpriteNode(imageNamed: "BG Sky Menu")
    
    let link = URL(string: "itms-apps://itunes.apple.com/app/id1201406607")
    
    override func didMove(to view: SKView) {
    
        skyMenuBackground.size = self.frame.size;
        skyMenuBackground.zPosition = 0
        
        
        self.addChild(skyMenuBackground)
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches{
            
            let location = touch.location(in: self);
            
            if atPoint(location).name  == "Start" {
                
                if let scene = GameplaySceneClass(fileNamed: "GameplayScene") {
                    
                    scene.scaleMode = .aspectFill
                    scene.size = self.frame.size
                    
                    
                    view!.presentScene(scene, transition: SKTransition.doorsOpenHorizontal(withDuration: (0.4)));
                }
            }
         
            
            if atPoint(location).name == "Rate" {
                
                if let url = NSURL(string: "itms-apps://itunes.apple.com/app/id1170263788") {
                    
                    UIApplication.shared.open(url as URL)
                    
                }
            }
            
        }
        
    }

}

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
