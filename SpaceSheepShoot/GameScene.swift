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
    
    private var bgTexture = SKTexture()
    private var playerShipTexture = SKTexture()
    
    private var bg = SKSpriteNode()
    private var playerShip = SKSpriteNode()
    
    private var bgObject = SKNode()
    private var playerShipObject = SKNode()
    
    override func didMove(to view: SKView) {
        bgTexture = SKTexture(imageNamed: "bg5.png")

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
        playerShipObject.addChild(playerShip)
    }
    
}
