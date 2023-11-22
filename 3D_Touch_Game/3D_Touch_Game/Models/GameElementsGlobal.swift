//
//  GamwElements.swift
//  3D_Touch_Game
//
//  Created by Александр Алешин on 04.11.2023.
//

import SpriteKit

    // структура игрока и врага
    struct CollisionBitMask {
        static let Player: UInt32 = 0x00
        static let Obstacle: UInt32 = 0x01
    }
    // размеры объектов (враги)
    enum ObstacleType: Int {
        case Small = 0
        case Medium = 1
        case Large = 2
    }
    // список кол-во объектов (враги)
    enum RowType: Int {
        
        case oneS = 0
        case oneM = 1
        case oneL = 2
        case twoS = 3
        case twoM = 4
        case threeS = 5
        
    }



