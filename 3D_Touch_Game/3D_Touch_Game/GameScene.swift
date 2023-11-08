//
//  GameScene.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 04.11.2023.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: SKSpriteNode!
    var player2: SKSpriteNode!
    
    
    var initalPlayerPosition: CGPoint!
    
    
    let motionManager = CMMotionManager()
    var xAccelerate: CGFloat = 0
    
    
    
    
 
       
 
    override func touchesEnded(_  touches: Set<UITouch>,   with event: UIEvent?) {
        
        resetPlayerPosition()
        

       }
       
       func resetPlayerPosition() {
           player.position = initalPlayerPosition
       }

    override func didMove(to view: SKView){
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        physicsWorld.contactDelegate = self
        addPlayer()
        addRow(type: RowType.oneL)
        
    }
    
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
    
        var lastUpdateTimeInterval = TimeInterval()
        var lastYieldTimeUnterval = TimeInterval()
    
        func updateWithTimeSunceLastUpdate (timeWithTimeSunceLastUpdate: CFTimeInterval){
            lastYieldTimeUnterval += timeWithTimeSunceLastUpdate
            if lastYieldTimeUnterval > 0.8 {
                lastYieldTimeUnterval = 0
                addRandomRow()
            }
        }
    
    
    override func update(_ curentTime: CFTimeInterval) {
                var timeWithTimeSunceLastUpdate = curentTime - lastUpdateTimeInterval
                lastUpdateTimeInterval = curentTime
        
                if timeWithTimeSunceLastUpdate > 1 {
                    timeWithTimeSunceLastUpdate = 1/60
                    lastUpdateTimeInterval = curentTime
                }
                updateWithTimeSunceLastUpdate(timeWithTimeSunceLastUpdate: timeWithTimeSunceLastUpdate)
            }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "PLAYER" {
            print("GAME OVER")
            // show Game Over Scene
            showGameOver()
            
        }
        
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdates(to: OperationQueue.current!) {(data: CMAccelerometerData?, error : Error? ) in
            if let acceleromenrData = data {
                let acceleration = acceleromenrData.acceleration
                self.xAccelerate = CGFloat(acceleration.x) * 0.75 + self.xAccelerate * 0.25
            }
        }
      
        
    }
  
    
    override func didSimulatePhysics() {
        player.position.x += xAccelerate * 50
        if player.position.x < -550 {
            player.position = CGPoint(x: 550, y: player.position.y)
        } else if player.position.x  > 550 {
            player.position = CGPoint(x: -550, y: player.position.y)
        }
    }
   
    func showGameOver() {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameOverScene = GameOverScene(size: self.size)
        self.view?.presentScene(gameOverScene, transition: transition)
    }
    
    
    
}

