//
//  GameScene.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 04.11.2023.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var player2: SKSpriteNode!
    
    
    var initalPlayerPosition: CGPoint!
    
    override func didMove(to view: SKView){
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        addPlayer()
        addRow(type: RowType.threeS)
        
    }
    
    override func update(_ curentTime: CFTimeInterval) {
        
    }
}
