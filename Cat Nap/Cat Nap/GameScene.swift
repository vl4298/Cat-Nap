//
//  GameScene.swift
//  Cat Nap
//
//  Created by Van Luu on 29/06/2016.
//  Copyright (c) 2016 Van Luu. All rights reserved.
//

import SpriteKit

protocol CustomNodeEvents {
  func didMoveToScene()
}

class GameScene: SKScene {
  
  var bedNode: BedNode!
  var catNode: CatNode!
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    
    let maxAspectRatio: CGFloat = 16.0 / 9.0
    let maxAspectHeight: CGFloat = size.width / maxAspectRatio
    let playableMargin: CGFloat = (size.height - maxAspectHeight) / 2.0
    
    let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height - playableMargin * 2)
    physicsBody = SKPhysicsBody(edgeLoopFromRect: playableRect)
    
    enumerateChildNodesWithName("//*") { node, _ in
      
      if let customNode = node as? CustomNodeEvents {
        customNode.didMoveToScene()
      }
    }
    
    bedNode = childNodeWithName("bed") as! BedNode
    catNode = childNodeWithName("//cat_body") as! CatNode
    
//    bedNode.setScale(1.5)
//    catNode.setScale(1.5)
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /* Called when a touch begins */
    
    for touch in touches {
      let location = touch.locationInNode(self)
      
      let sprite = SKSpriteNode(imageNamed:"Spaceship")
      
      sprite.xScale = 0.5
      sprite.yScale = 0.5
      sprite.position = location
      
      let action = SKAction.rotateByAngle(CGFloat(M_PI), duration:1)
      
      sprite.runAction(SKAction.repeatActionForever(action))
      
      self.addChild(sprite)
    }
  }
  
  override func update(currentTime: CFTimeInterval) {
    /* Called before each frame is rendered */
  }
}
