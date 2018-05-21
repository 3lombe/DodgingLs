//
//  ItemController.swift
//  DodgingLs
//
//  Created by Elombe Kisala on 1/30/17.
//  Copyright © 2017 Elombe Kisala. All rights reserved.
//

import SpriteKit

struct ColliderType {
    
    static let PLAYER: UInt32 = 0;
    static let L_AND_COIN: UInt32 = 1;
    
}

class ItemController {
    
    private var minX = CGFloat(-240), maxX = CGFloat(240);

    func spawnItems(scene: SKScene) -> SKSpriteNode {
        
        
        let item: SKSpriteNode?;
        
        if Int(randomBetweenNumbers(firstNum: 0, secondNum: 10)) >= 3 {
            
            item = SKSpriteNode(imageNamed: "L");
            
            item!.name = "L";
            item!.setScale(0.6);
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2);
            
        } else {
            
            item = SKSpriteNode(imageNamed: "Coin");
            
            item!.name = "Coin";
            item!.setScale(0.6);
            item!.physicsBody = SKPhysicsBody(circleOfRadius: item!.size.height / 2);
            
        }
        
        item!.physicsBody?.categoryBitMask = ColliderType.L_AND_COIN;
        item!.zPosition = 3;
        item!.anchorPoint = CGPoint(x: 0.5, y: 0.5);
        item!.position.x = randomBetweenNumbers(firstNum: minX, secondNum: maxX);
        item!.position.y = scene.frame.size.height + 100;
        
        
        
        return item!;
    }
    
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
            
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum);
        
    }

}




























