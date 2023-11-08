//
//  GamwElements.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 04.11.2023.
//

import SpriteKit

struct CollisionBitMask {
    static let Player: UInt32 = 0x00
    static let Obstacle: UInt32 = 0x01
}

enum ObstacleType: Int {
    case Small = 0
    case Medium = 1
    case Large = 2
}

enum RowType: Int {
    
    case oneS = 0
    case oneM = 1
    case oneL = 2
    case twoS = 3
    case twoM = 4
    case threeS = 5
    
}



extension GameScene {
    
    func addPlayer() {
        
        player = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
        player.position = CGPoint(x: self.size.width / 50, y: -850)
        player.name = "PLAYER"
        player.physicsBody?.isDynamic = false
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.categoryBitMask = CollisionBitMask.Player
        player.physicsBody?.collisionBitMask = 0
        player.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
//        player2 = SKSpriteNode(color: UIColor.red, size: CGSize(width: 50, height: 50))
//        player2.position = CGPoint(x: self.size.width / 50, y: -850)
//        player2.name = "PLAYER"
//        player2.physicsBody?.isDynamic = false
//        player2.physicsBody = SKPhysicsBody(rectangleOf: player2.size)
//        player2.physicsBody?.categoryBitMask = CollisionBitMask.Player
//        player2.physicsBody?.collisionBitMask = 0
//        player2.physicsBody?.contactTestBitMask = CollisionBitMask.Obstacle
        
        addChild(player)
//        addChild(player2)
        
        initalPlayerPosition = player.position
        
    }
    
    func addObstacle (type: ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor(white: 1, alpha: 1), size: CGSize(width: 0, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        
        
        switch type {
        case .Small:
            obstacle.size.width = self.size.width * 0.2
            break
        case .Medium:
            obstacle.size.width = self.size.width * 0.35
            break
        case .Large:
            obstacle.size.width = self.size.width * 0.75
            break
        }
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
    }
    
    func addMovement (obstacle: SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: obstacle.position.x , y: -obstacle.position.y), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actionArray))
        
        
    }
    
    func addRow (type:RowType) {
        switch type {
        case .oneS:
            let obst = addObstacle(type: .Small)
            obst.position = CGPoint(x: self.size.width / 50, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .oneM:
            let obst = addObstacle(type: .Medium)
            obst.position = CGPoint(x: self.size.width / 50, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .oneL:
            let obst = addObstacle(type: .Large)
            obst.position = CGPoint(x: self.size.width / 50, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .twoS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.size.width / 50  + 50 + obst1.size.width, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width / 50 - obst2.size.width / 2 - 150, y: obst1.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            
            break
        case .twoM:
            let obst1 = addObstacle(type: .Medium)
            let obst2 = addObstacle(type: .Medium)
            
            obst1.position = CGPoint(x: obst1.size.width / 50  - 100 + obst1.size.width, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width / 50 - obst2.size.width / 2 - 150, y: obst1.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            break
        case .threeS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            let obst3 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: self.size.width / 50  - 150 - obst1.size.width , y: obst1.position.y) // left
            obst2.position = CGPoint(x: self.size.width / 50 + 150 + obst2.size.width, y: obst1.position.y) // right
            obst3.position = CGPoint(x: self.size.width / 50 , y: obst1.position.y) // center
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break
        }
    }
    

}

