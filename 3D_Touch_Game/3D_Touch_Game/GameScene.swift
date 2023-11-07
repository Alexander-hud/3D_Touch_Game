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
    
    override func touchesMoved(_ touches: Set<UITouch>,  with event: UIEvent?) {
        let touch = touches.first
                if let location = touch?.location(in: self){
                    if location.x > 0{
                        let newPoint = player.position.x
                        player.run(SKAction.moveBy(x: 25, y: 0, duration: 0.1))
                        player2.run(SKAction.moveBy(x: -25, y: 0, duration: 0.1))
                    }else{
                        player.run(SKAction.moveBy(x: -50, y: 0, duration: 0.1))
                        player2.run(SKAction.moveBy(x: 50, y: 0, duration: 0.1))
                    }

                }
   
        
        
        

    }
       
 
    override func touchesEnded(_  touches: Set<UITouch>,   with event: UIEvent?) {
        resetPlayerPosition()
//        player.removeAllActions()

       }
       
       func resetPlayerPosition() {
           player.position = initalPlayerPosition
           player2.position = initalPlayerPosition
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
        }
        
       
    }
  
   

    
    
    
}

