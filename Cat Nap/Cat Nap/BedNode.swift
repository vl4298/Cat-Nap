//
//  BedNode.swift
//  Cat Nap
//
//  Created by Van Luu on 02/07/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import SpriteKit

class BedNode: SKSpriteNode {

}

extension BedNode: CustomNodeEvents {
  func didMoveToScene() {
    physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 40, height: 30))
    physicsBody?.dynamic = false
  }
}