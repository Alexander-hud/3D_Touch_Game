//
//  GameScene.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 04.11.2023.
//

import SpriteKit
import CoreMotion
import AVFoundation
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var starField: SKEmitterNode!
    var scoreLabel: SKLabelNode!
    var playerSize = CGSize(width: 50, height: 50)

    var lastUpdateTimeInterval = TimeInterval()
    var lastYieldTimeUnterval = TimeInterval()
    
    let motionManager = CMMotionManager()
//    var xAccelerate: CGFloat = 0
    
    var initalPlayerPosition: CGPoint!
    
    // счетчки
    var score: Int = 5 {
        didSet {
            scoreLabel.text = "Счет: \(score)"
        }
    }
 
    override func didMove(to view: SKView){
        
        // label счетчик
        scoreLabel = SKLabelNode(text: "Счет: 0")
        scoreLabel.fontName = "Optima-ExtraBlack"
        scoreLabel.fontSize = 64
        scoreLabel.fontColor = UIColor.white
        scoreLabel.position = CGPoint(x: -350 , y: 1000)
        score = 0
        
        self.addChild(scoreLabel)
        
        // анимация фона
        starField = SKEmitterNode(fileNamed: "star_cosmo")
        starField.position = CGPoint(x: 0, y: 1472)
        starField.advanceSimulationTime(10)
        self.addChild(starField)
        
        starField.zPosition = -1
        
        // параметры объекта игрока
        func addPlayer() {
            
            player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
            player = SKSpriteNode(imageNamed: "imageUserObject")
            player.position = CGPoint(x: self.size.width / 50, y: -850)
            player.name = "PLAYER"
            player.physicsBody?.isDynamic = false
            player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
            player.physicsBody?.categoryBitMask = CollisionBitMask.Player
            player.physicsBody?.collisionBitMask = 0
            player.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
            
            addChild(player)
            
            initalPlayerPosition = player.position
        }
        
        // физика игры (гравитация)
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        addPlayer()
        addRow(type: RowType.threeS)
        scene?.scaleMode = .aspectFill
        
    }
}

