//
//  GameOverScene.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 07.11.2023.
//

import SpriteKit

class GameOverScene: SKScene {
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(size: CGSize) {
        super.init(size: size)
        
      
        
        self.backgroundColor = SKColor.black
        let messagge = "GAME OVER"
        
        let label = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        label.text = messagge
        label.fontSize = 86
        label.fontColor = SKColor.white
        label.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)

        
        addChild(label)
        
        
        let replayMessage = "Replay Game"
        let replayButton = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        replayButton.text = replayMessage
        replayButton.fontSize = 64
        replayButton.fontColor = SKColor.white
        replayButton.position = CGPointMake(self.size.width/2, 1000)
        replayButton.name = "replay"
        addChild(replayButton)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)

        if touchedNode.name != nil {
            if let nextScene = GameScene(fileNamed: "GameScene") {
                            nextScene.scaleMode = .aspectFill
                            self.view?.presentScene(nextScene, transition: SKTransition() )
                        
                        }
        }


        
        }
        
        
        }
    

        

    

