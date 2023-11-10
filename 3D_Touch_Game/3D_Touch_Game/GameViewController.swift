//
//  GameViewController.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 04.11.2023.
//

import UIKit
import SpriteKit
import GameplayKit

import AVFoundation


class GameViewController: UIViewController {

    var backgroundMusicPlayer = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                
                let bgMusicURL = Bundle.main.url(forResource: "Statement", withExtension: "mp3")
                do {
                    try backgroundMusicPlayer = AVAudioPlayer(contentsOf: bgMusicURL!)
                } catch {
                    print("cant play music")
                }
                
                backgroundMusicPlayer.numberOfLoops = -1
                backgroundMusicPlayer.prepareToPlay()
                backgroundMusicPlayer.play()
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
     
        }
        
        
        
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
