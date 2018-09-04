//
//  GameScene.swift
//  SpaceSheepShoot
//
//  Created by Anton on 02.09.2018.
//  Copyright © 2018 Switch. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private let velocityMultiplier: CGFloat = 0.12
    
    private var bgTexture = SKTexture()
    private var playerShipTexture = SKTexture()
    
    private var bg = SKSpriteNode()
    private var playerShip = SKSpriteNode()
    
    private var bgObject = SKNode()
    private var playerShipObject = SKNode()
    
    private var playerGroupe: UInt32 = 0x1 << 1
    private var groundGroupe: UInt32 = 0x2 << 2
    
    override func didMove(to view: SKView) {
        bgTexture = SKTexture(imageNamed: "bg5.png")
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

        createObject()
        createGame()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
    private func createObject() {
        self.addChild(bgObject)
        self.addChild(playerShipObject)
    }

    private func createGame() {
        createBg()
        setupJoystick()
        createPlayerShip(imageNmaed: "playerShip2_red", position: CGPoint(x: 0, y: 0))
    }
    
    
    private func createBg() {
        bg = SKSpriteNode(texture: bgTexture)
        bg.name = "BackGround"
        bg.position = CGPoint(x: 0, y: 0)
        bg.size.width = self.frame.width
        bg.size.height = self.frame.height
        bg.zPosition = -1
        bgObject.addChild(bg)
    }
    
    private func createPlayerShip(imageNmaed image: String, position: CGPoint) {
        playerShipTexture = SKTexture(imageNamed: image)
        playerShip = SKSpriteNode(texture: playerShipTexture)
        playerShip.size.height = 75
        playerShip.size.width = 112
        playerShip.position = position
        playerShip.zPosition = 1
        
        playerShip.physicsBody?.categoryBitMask = playerGroupe
        playerShip.physicsBody?.contactTestBitMask = groundGroupe
        playerShip.physicsBody?.contactTestBitMask = groundGroupe
        playerShip.physicsBody?.linearDamping = 0.7
        playerShip.physicsBody?.angularDamping = 0.7
        playerShip.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: playerShip.size.width-5, height: playerShip.size.height-5))
        playerShip.physicsBody?.isDynamic = true
        playerShip.physicsBody?.allowsRotation = true
        
        playerShipObject.addChild(playerShip)
    }
    
    lazy var analogJoysticLeft: AnalogJoystick = {
       let jsLeft = AnalogJoystick(diameter: 150, colors: (substrate: UIColor.darkGray.withAlphaComponent(0.3), stick: UIColor.darkGray), images: nil)
        jsLeft.position = CGPoint(x: ScreenSize.width * -0.95 + jsLeft.radius + 45, y: ScreenSize.height * -0.95 + jsLeft.radius + 45)
        jsLeft.zPosition = 2
        return jsLeft
    }()
    
    lazy var analogJoysticRight: AnalogJoystick = {
        let jsRight = AnalogJoystick(diameter: 150, colors: (substrate: UIColor.darkGray.withAlphaComponent(0.3), stick: UIColor.darkGray), images: nil)
        jsRight.position = CGPoint(x: ScreenSize.width * 0.95 - jsRight.radius - 45, y: ScreenSize.height * -0.63 )
        jsRight.zPosition = 2
        return jsRight
    }()
    
    private func setupJoystick() {
        addChild(analogJoysticLeft)
        addChild(analogJoysticRight)
        analogJoysticLeft.trackingHandler = { [unowned self] data in
            self.playerShip.position = CGPoint(x: self.playerShip.position.x + (data.velocity.x * self.velocityMultiplier), y: self.playerShip.position.y + (data.velocity.y * self.velocityMultiplier))
            self.playerShip.zRotation = data.angular
        }
    }
    
}
