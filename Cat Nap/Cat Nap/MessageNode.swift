//
//  MessageNode.swift
//  Cat Nap
//
//  Created by Van Luu on 02/07/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import SpriteKit

class MessageNode: SKLabelNode {

  convenience init(message: String) {
    self.init(fontNamed: "AvenirNext-Regular")
    
    text = message
    fontSize = 150.0
    fontColor = SKColor.grayColor()
    zPosition = 100.0
    
    let front = SKLabelNode(fontNamed: "AvenirNext-Regular")
    front.text = message
    front.fontSize = 150.0
    front.fontColor = SKColor.whiteColor()
    front.position = CGPoint(x: -2, y: -2)
    addChild(front)
    
    physicsBody = SKPhysicsBody(circleOfRadius: 10.0)
    physicsBody?.categoryBitMask = PhysicsCateGory.Label
    physicsBody?.collisionBitMask = PhysicsCateGory.Edge
    physicsBody?.restitution = 0.7
  }
}

