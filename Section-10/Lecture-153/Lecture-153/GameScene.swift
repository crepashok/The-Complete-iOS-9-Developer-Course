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
    
    var bg = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        
        // Adding animated background
        let bgTexture = SKTexture(imageNamed: "bg.png")
        
        let movebg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 9)
        
        let replaceBG = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        
        let moveBgForever = SKAction.repeatActionForever(SKAction.sequence([movebg, replaceBG]))
        
        for i in 0 ..< 3 {
            
            let counter:CGFloat = CGFloat(i)
            
            bg = SKSpriteNode(texture: bgTexture)
            
            bg.position = CGPoint(x: bgTexture.size().width / 2 + bgTexture.size().width * counter, y: CGRectGetMidY(self.frame))
            
            bg.size.height = self.frame.height
            
            bg.runAction(moveBgForever)
            
            self.addChild(bg)
            
        }
        
        
        
        // Adding animated bird
        let birdTexture1 = SKTexture(imageNamed: "flappy1.png")
        
        let birdTexture2 = SKTexture(imageNamed: "flappy2.png")
        
        let animation = SKAction.animateWithTextures([birdTexture1, birdTexture2], timePerFrame: 0.1)
        
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture1)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture1.size().height / 2)
        
        bird.physicsBody!.dynamic = true
        
        bird.runAction(makeBirdFlap)
        
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(bird)
        
        
        
        // Adding ground
        let ground = SKNode()
        
        ground.position = CGPointMake(0, 0)
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        
        ground.physicsBody!.dynamic = false
        
        self.addChild(ground)
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        bird.physicsBody!.velocity = CGVectorMake(0, 0)
        
        bird.physicsBody!.applyImpulse(CGVectorMake(0, 50))
        
    }
   
    
    
    override func update(currentTime: CFTimeInterval) {
        
        
        
    }
}
