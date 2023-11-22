//
//  GameSceneDelegate.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 22.11.2023.
//

import SpriteKit
import CoreMotion
import AVFoundation
import GameplayKit

extension GameScene {
    
    // MARK: gamePlay object
    override func touchesMoved(_ touches: Set<UITouch>, with: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let move = SKAction.move(to: location, duration: 0.25)
            let sequence = SKAction.sequence([move])
            
            player.run(sequence)
        }
    }
    
    // переход на страницу GameOver
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.node?.name == "PLAYER" {
            print("GAME OVER")
            // show Game Over Scene
            showGameOver()
        }
    }
    
    // переход на страницу GameOver (время перехода)
    func showGameOver() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transition)
    }
    
    // забыл для чего это нужно
    override func update(_ curentTime: CFTimeInterval) {
        var timeWithTimeSunceLastUpdate = curentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = curentTime
        
        if timeWithTimeSunceLastUpdate > 1 {
            timeWithTimeSunceLastUpdate = 1/60
            lastUpdateTimeInterval = curentTime
        }
        updateWithTimeSunceLastUpdate(timeWithTimeSunceLastUpdate: timeWithTimeSunceLastUpdate)
    }
    
    // тайминг появляения врагов
    func updateWithTimeSunceLastUpdate (timeWithTimeSunceLastUpdate: CFTimeInterval){
        lastYieldTimeUnterval += timeWithTimeSunceLastUpdate
        if lastYieldTimeUnterval > 0.8 {
            lastYieldTimeUnterval = 0
            addRandomRow()
        }
    }
    
    // добавляем количество разных объектов (врагов)
    func addRandomRow() {
        let randomNumber = Int(arc4random_uniform(6))
        
        switch randomNumber {
        case 0:
            addRow(type: RowType(rawValue: 0)!)
            break
        case 1:
            addRow(type: RowType(rawValue: 1)!)
            break
        case 2:
            addRow(type: RowType(rawValue: 2)!)
            break
        case 3:
            addRow(type: RowType(rawValue: 3)!)
            break
        case 4:
            addRow(type: RowType(rawValue: 4)!)
            break
        case 5:
            addRow(type: RowType(rawValue: 5)!)
            break
        default:
            break
        }
        
    }
    
    // после того как пользователь убрал палец с экрана, объект игрока остается на том же месте
    func resetPlayerPosition() {
        player.position = initalPlayerPosition
    }
    
    // параметры позиции и размеров врагов
    func addRow (type:RowType) {
        switch type {
        case .oneS:
            let obst = addObstacle(type: .Small)
            obst.position = CGPoint(x: self.size.width / 400, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            
            break
        case .oneM:
            let obst = addObstacle(type: .Medium)
            obst.position = CGPoint(x: self.size.width / 100, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            
            break
        case .oneL:
            let obst = addObstacle(type: .Large)
            obst.position = CGPoint(x: self.size.width / 100, y: obst.position.y)
            addMovement(obstacle: obst)
            addChild(obst)
            break
        case .twoS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: obst1.size.width / 100  + 150 + obst1.size.width, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width / 100 - obst2.size.width / 2 - 150, y: obst1.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            
            break
        case .twoM:
            let obst1 = addObstacle(type: .Medium)
            let obst2 = addObstacle(type: .Medium)
            
            obst1.position = CGPoint(x: obst1.size.width / 100  - 100 + obst1.size.width, y: obst1.position.y)
            obst2.position = CGPoint(x: self.size.width / 100 - obst2.size.width / 2 - 100, y: obst1.position.y)
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            
            addChild(obst1)
            addChild(obst2)
            break
        case .threeS:
            let obst1 = addObstacle(type: .Small)
            let obst2 = addObstacle(type: .Small)
            let obst3 = addObstacle(type: .Small)
            
            obst1.position = CGPoint(x: self.size.width / 100  - 200 - obst1.size.width , y: obst1.position.y) // left
            obst2.position = CGPoint(x: self.size.width / 100 + 200 + obst2.size.width, y: obst1.position.y) // right
            obst3.position = CGPoint(x: self.size.width / 100 , y: obst1.position.y) // center
            
            addMovement(obstacle: obst1)
            addMovement(obstacle: obst2)
            addMovement(obstacle: obst3)
            
            addChild(obst1)
            addChild(obst2)
            addChild(obst3)
            break
        }
    }
    
    // счетчик
    func addMovement (obstacle: SKSpriteNode) {
        var actionArray = [SKAction]()
        
        actionArray.append(SKAction.move(to: CGPoint(x: obstacle.position.x , y: -obstacle.position.y), duration: TimeInterval(3)))
        actionArray.append(SKAction.removeFromParent())
        
        obstacle.run(SKAction.sequence(actionArray))
        print("xxx")
        if obstacle.position.y > player.position.y {
            score += 1
            print(score)
        }
    }
    
    // размеры объектов (врагов)
    func addObstacle (type: ObstacleType) -> SKSpriteNode {
        let obstacle = SKSpriteNode(color: UIColor(white: 1, alpha: 1), size: CGSize(width: 0, height: 30))
        obstacle.name = "OBSTACLE"
        obstacle.physicsBody?.isDynamic = true
        
        
        switch type {
        case .Small:
            obstacle.size.width = 100
            break
        case .Medium:
            obstacle.size.width = 100
            break
        case .Large:
            obstacle.size.width = 100
            break
        }
        obstacle.position = CGPoint(x: 0, y: self.size.height + obstacle.size.height)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.size)
        obstacle.physicsBody?.categoryBitMask = CollisionBitMask.Obstacle
        obstacle.physicsBody?.collisionBitMask = 0
        
        return obstacle
        
    }
}
        
    
    // MARK: gamePlay object in xAccelerate
    //        motionManager.accelerometerUpdateInterval = 0.2
    //        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {(data: CMAccelerometerData?, error : Error? ) in
    //            if let acceleromenrData = data {
    //                let acceleration = acceleromenrData.acceleration
    //                self.xAccelerate = CGFloat(acceleration.x) * 0.75 + self.xAccelerate * 0.25
    //            }
    //        }
    
    // MARK: gamePlay object in xAccelerate
    //    override func didSimulatePhysics() {
    //        player.position.x += xAccelerate * 50
    //        if player.position.x < -550 {
    //            player.position = CGPoint(x: 550, y: player.position.y)
    //        } else if player.position.x  > 550 {
    //            player.position = CGPoint(x: -550, y: player.position.y)
    //        }
    //    }
    

