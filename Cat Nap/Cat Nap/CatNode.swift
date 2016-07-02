//
//  CatNode.swift
//  Cat Nap
//
//  Created by Van Luu on 02/07/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import SpriteKit

class CatNode: SKSpriteNode {

}

extension CatNode: CustomNodeEvents {
  func didMoveToScene() {
    let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
    parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture, size: catBodyTexture.size())
    parent!.physicsBody?.categoryBitMask = PhysicsCateGory.Cat
    parent!.physicsBody?.collisionBitMask = PhysicsCateGory.Block
  }
}
