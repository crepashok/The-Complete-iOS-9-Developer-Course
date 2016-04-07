//
//  GameScene.swift
//  Lecture-153
//
//  Created by Pavlo Cretsu on 4/7/16.
//  Copyright (c) 2016 Pavlo Cretsu. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var score = 0
    
    var scoreLabel = SKLabelNode()
    
    var bird = SKSpriteNode()
    
    var bg = SKSpriteNode()
    
    var pipe1 = SKSpriteNode()
    
    var pipe2 = SKSpriteNode()
    
    var movingObjects = SKSpriteNode()
    
    var gameOver = false
    
    var gameOverLabel = SKLabelNode()
    
    var labelContainer = SKSpriteNode()
    
    enum ColliderType: UInt32 {
    
        case Bird = 1
        
        case Object = 2
        
        case Gap = 4
        
    }
    
    
    func makeBackground() {
        
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
            
            movingObjects.addChild(bg)
            
        }
    }
    
    
    
    override func didMoveToView(view: SKView) {
        
        self.physicsWorld.contactDelegate = self
        
        self.addChild(movingObjects)
        
        self.addChild(labelContainer)
        
        makeBackground()
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), self.frame.size.height - 70)
        self.addChild(scoreLabel)
        
        
        
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
        
        bird.physicsBody!.allowsRotation = false
        
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
        
        movingObjects.addChild(pipe1)
        
        
        
        let pipe2Texture = SKTexture(imageNamed: "pipe2.png")
        
        let pipe2 = SKSpriteNode(texture: pipe2Texture)
        
        pipe2.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) - pipe2Texture.size().height/2 - gapHeight / 2 + pipeOffset)
        
        pipe2.runAction(moveAndRemovePipes)
        
        pipe2.physicsBody = SKPhysicsBody(rectangleOfSize: pipeTexture.size())
        
        pipe2.physicsBody!.dynamic = false
        
        pipe2.physicsBody!.categoryBitMask = ColliderType.Object.rawValue
        
        pipe2.physicsBody!.contactTestBitMask = ColliderType.Object.rawValue
        
        pipe2.physicsBody!.collisionBitMask = ColliderType.Object.rawValue
        
        movingObjects.addChild(pipe2)
        
        
        let gap = SKNode()
        
        gap.position = CGPoint(x: CGRectGetMidX(self.frame) + self.frame.size.width, y: CGRectGetMidY(self.frame) + pipeOffset)
        
        gap.runAction(moveAndRemovePipes)
        
        gap.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(pipe1.size.width, gapHeight))
        
        gap.physicsBody!.dynamic = false
        
        gap.physicsBody!.categoryBitMask = ColliderType.Gap.rawValue
        
        gap.physicsBody!.contactTestBitMask = ColliderType.Bird.rawValue
        
        gap.physicsBody!.collisionBitMask = ColliderType.Gap.rawValue
        
        movingObjects.addChild(gap)
    }
    
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == ColliderType.Gap.rawValue || contact.bodyB.categoryBitMask == ColliderType.Gap.rawValue {
            
            score += 1
            
            scoreLabel.text = String(score)
            
        } else {
            
            if gameOver == false {
                
                gameOver = true
                
                self.speed = 0
                
                gameOverLabel.fontName = "Helvetica"
                gameOverLabel.fontSize = 30
                gameOverLabel.text = "Game Over! Tap to play again."
                gameOverLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
                labelContainer.addChild(gameOverLabel)
                
            }
            
        }
        
    }
    
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if gameOver == false {
            
            bird.physicsBody!.velocity = CGVectorMake(0, 0)
            
            bird.physicsBody!.applyImpulse(CGVectorMake(0, 50))
        
        } else {
        
            score = 0
            
            scoreLabel.text = "0"
            
            bird.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
            
            bird.physicsBody!.velocity = CGVectorMake(0, 0)
            
            movingObjects.removeAllChildren()
            
            makeBackground()
            
            self.speed = 1
            
            gameOver = false
            
            labelContainer.removeAllChildren()
        }
        
    }
}
