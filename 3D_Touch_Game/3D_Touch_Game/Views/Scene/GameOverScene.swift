//
//  GameOverScene.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 07.11.2023.
//

import SpriteKit

// MARK: Класс страницы GameOver
class GameOverScene: SKScene {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = SKColor.black // фон страницы
        
        // label счетчик
        let scoreStatus = "Ваш счет: \(GameScene().score)"
        let scoreLabel = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        scoreLabel.text = scoreStatus
        scoreLabel.fontSize = 86
        scoreLabel.fontColor = SKColor.white
        scoreLabel.position = CGPoint(x: self.size.width / 2, y: 1600)

        addChild(scoreLabel)
        
        // label Game Over
        let userStatus = "GAME OVER"
        let userStatusLabel = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        userStatusLabel.text = userStatus
        userStatusLabel.fontSize = 86
        userStatusLabel.fontColor = SKColor.white
        userStatusLabel.position = CGPoint(x: self.size.width / 2, y: self.size.height / 2)

        addChild(userStatusLabel)
         
        // button начать игру заново
        let replayMessage = "Replay Game"
        let replayButton = SKLabelNode(fontNamed: "Optima-ExtraBlack")
        replayButton.text = replayMessage
        replayButton.fontSize = 64
        replayButton.fontColor = SKColor.white
        replayButton.position = CGPointMake(self.size.width/2, 1000)
        replayButton.name = "replay"
        
        addChild(replayButton)
        
    }
}
    

        

    

