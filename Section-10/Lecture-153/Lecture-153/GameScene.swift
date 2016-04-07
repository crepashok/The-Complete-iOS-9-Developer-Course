//
//  GameScene.swift
//  Lecture-153
//
//  Created by Pavlo Cretsu on 4/7/16.
//  Copyright (c) 2016 Pavlo Cretsu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    
    var bird = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        
        let birdTexture1 = SKTexture(imageNamed: "flappy1.png")
        
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.1)
        
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture1)
        
        bird.runAction(makeBirdFlap)
        
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(bird)
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        
        
    }
   
    
    
    override func update(currentTime: CFTimeInterval) {
        
        
        
    }
}
