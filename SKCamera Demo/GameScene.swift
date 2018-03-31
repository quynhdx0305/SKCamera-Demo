//
//  GameScene.swift
//  SKCamera Demo
//
//  Created by Sean Allen on 3/29/18.
//  Copyright © 2018 Humboldt Code Club. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: Properties
    
    let gameLayer: SKNode!
    let demoCamera: DemoCamera!
    
    // MARK: Initializers
    
    // When not using an .sks file to build our scenes we must have this method
    required init?(coder aDecoder: NSCoder) {
        fatalError("Coder not used in this app")
    }
    
    // Init
    override init(size: CGSize) {
        
        // Initialize the game layer node that will hold our game pieces and
        // move the gameLayer node to the center of the scene
        gameLayer = SKNode()
        gameLayer.position = CGPoint(x: size.width / 2, y: size.height / 2)
        
        // Initailize the demo camera
        demoCamera = DemoCamera()
        
        // Call the super class initializer
        super.init(size: size)
        
        // Add the game layer node to the scene
        addChild(gameLayer)
    }
    
    // MARK: Scene Lifecycle
    
    override func didMove(to view: SKView) {
        
        // Call any custom code to setup the scene
        addGamePieces()
        
        // Set the scene's camera
        camera = demoCamera
    }
    
    // Called before each frame is rendered
    override func update(_ currentTime: TimeInterval) {
        demoCamera.velocity.x *= demoCamera.friction
        demoCamera.velocity.y *= demoCamera.friction
        demoCamera.velocity.z *= demoCamera.friction
        
        demoCamera.attraction.z *= demoCamera.attractiveForce
        
        demoCamera.position.x -= demoCamera.velocity.x
        demoCamera.position.y += demoCamera.velocity.y
        demoCamera.setScale(demoCamera.xScale - demoCamera.velocity.z)
        
        if (demoCamera.xScale < 1.0) {
            demoCamera.attraction.z = 1.0 - demoCamera.xScale
        } else if (demoCamera.xScale > 4.0) {
            demoCamera.attraction.z = 4.0 - demoCamera.xScale
        } else {
            demoCamera.attraction.z = 0.0
        }
        
    }
    
    // MARK: Private Functions
    
    private func addGamePieces() {
        let columns = 16
        let rows = 16
        for column in 0...columns {
            for row in 0...rows {
                let newGamePiece = SKShapeNode(circleOfRadius: 50.0)
                newGamePiece.position = CGPoint(x: (column * 120) - (columns * 60), y: (row * 120) - (rows * 60))
                newGamePiece.strokeColor = UIColor.blue
                newGamePiece.fillColor = UIColor.blue
                gameLayer.addChild(newGamePiece)
            }
        }
    
    }
}
