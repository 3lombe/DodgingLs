//
//  Player.swift
//  DodgingLs
//
//  Created by Elombe Kisala on 1/30/17.
//  Copyright © 2017 Elombe Kisala. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    private var minX = CGFloat(-270), maxX = CGFloat(270);
    
    func initializePlayer() {
        
        name = "Player";
        
        physicsBody = SKPhysicsBody(circleOfRadius: size.height / 2);
        
        physicsBody?.affectedByGravity = false;
        
        physicsBody?.isDynamic = false;
        
        physicsBody?.categoryBitMask = ColliderType.PLAYER;
        
        physicsBody?.contactTestBitMask = ColliderType.L_AND_COIN;
        
        
    }
    
    func move(left: Bool) {
        
        if left {
            
            position.x -= 25;
            
            if position.x < minX {
                
                position.x = minX;
                
            }
            
        } else {
            
            position.x += 25;
            
            if position.x > maxX {
                
                position.x = maxX;
                
            }
            
        }
        
    }
    
} 














