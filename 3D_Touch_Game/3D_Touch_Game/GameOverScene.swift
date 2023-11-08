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
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let transition = SKTransition.fade(withDuration: 0.5)
        let gameScene = GameScene(size: self.size)
        self.view?.presentScene(gameScene, transition: transition)
    }
    
}
