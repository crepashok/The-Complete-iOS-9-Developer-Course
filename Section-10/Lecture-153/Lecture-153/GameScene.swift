//
//  GameScene.swift
//  Lecture-153
//
//  Created by Pavlo Cretsu on 4/7/16.
//  Copyright (c) 2016 Pavlo Cretsu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var bird = SKSpriteNode()
    
    var bg = SKSpriteNode()
    
    var pipe1 = SKSpriteNode()
    
    var pipe2 = SKSpriteNode()
    
    enum ColliderType: UInt32 {
    
        case Bird = 1
        
        case Object = 2
        
    }
    
    var gameOver = false
    
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
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
        
        let animation = SKAction.animateWithTextures([birdTexture1, SKTexture(imageNamed: "flappy2.png")], timePerFrame: 0.2)
        
        let makeBirdFlap = SKAction.repeatActionForever(animation)
        
        bird = SKSpriteNode(texture: birdTexture1)
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture1.size().height / 2)
        
        bird.physicsBody!.dynamic = true
        
        bird.physicsBody!.categoryBitMask = ColliderType.Bird.rawValue
        
        bird.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        
        bird.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        bird.runAction(makeBirdFlap)
        
        bird.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))
        
        self.addChild(bird)
        
        
        
        // Adding ground
        let ground = SKNode()
        
        ground.position = CGPointMake(0, 0)
        
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(self.frame.size.width, 1))
        
        ground.physicsBody!.dynamic = false
        
        ground.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        
        ground.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        
        ground.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        self.addChild(ground)
        
        
        _ = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(self.makePipes), userInfo: nil, repeats: true)
    }
    
    
    
    func makePipes() {
        
        let gapHeight = bird.size.height * 4
        
        let movementAmmount = arc4random() % UInt32(self.frame.size.height / 2)
        
        let pipeOffset = CGFloat(movementAmmount) - self.frame.size.height / 4
        
        let movePipes = SKAction.moveByX(-self.frame.size.width * 2, y: 0, duration: NSTimeInterval(self.frame.width) / 100)
        
        let removePipes = SKAction.removeFromParent()
        
        let moveAndRemovePipes = SKAction.sequence([movePipes, removePipes])
        
        
        let pipeTexture = SKTexture(imageNamed: "pipe1.png")
        
        let pipe1 = SKSpriteNode(texture: pipeTexture)
        
        pipe1.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeTexture.size().height / 2 + gapHeight / 2 + pipeOffset)
        
        pipe1.runAction(moveAndRemovePipes)
        
        pipe1.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTexture.size())
        
        pipe1.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        
        pipe1.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        
        pipe1.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        pipe1.physicsBody!.dynamic = false
        
        self.addChild(pipe1)
        
        
        
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipe2Texture)
        
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipe2Texture.size().height / 2 - gapHeight / 2 + pipeOffset)
        
        pipe2.runAction(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTexture.size())
        
        pipe2.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        
        pipe2.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        pipe2.physicsBody!.dynamic = false
        
        self.addChild(pipe2)
        
    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        gameOver = true
        
        self.speed = 0
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if gameOver == false {
            
            bird.physicsBody!.velocity = CGVectorMake(0, 0)
            
            bird.physicsBody!.applyImpulse(CGVectorMake(0, 50))
        
        }
        
    }
   
    
    
    override func update(currentTime: CFTimeInterval) {
        
        
        
    }
}
