//
//  GameOverSceneDelegate.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 22.11.2023.
//

import SpriteKit

extension GameOverScene {
    
    // обработка события, при клике рестарт переход на экран GameScene
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        let touch = touches.first! as UITouch
        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        let transition = SKTransition.fade(withDuration: 0.5)
        if touchedNode.name != nil {
            if let nextScene = GameScene(fileNamed: "GameScene") {
                            nextScene.scaleMode = .aspectFill
                            self.view?.presentScene(nextScene, transition: transition )
            }
        }
    }
}
