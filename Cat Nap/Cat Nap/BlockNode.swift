//
//  BlockNode.swift
//  Cat Nap
//
//  Created by Van Luu on 02/07/2016.
//  Copyright © 2016 Van Luu. All rights reserved.
//

import SpriteKit

class BlockNode: SKSpriteNode {
}

extension BlockNode: CustomNodeEvents {
  func didMoveToScene() {
    userInteractionEnabled = true
  }
}

extension BlockNode: interactiveNodes {
  func interactive() {
    userInteractionEnabled = false
    
    runAction(SKAction.sequence([
      SKAction.playSoundFileNamed("pop.mp3", waitForCompletion: false),
      SKAction.scaleTo(0.8, duration: 1.0),
      SKAction.removeFromParent()
    ]))
  }
}

extension BlockNode {
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    super.touchesBegan(touches, withEvent: event)
    
    interactive()
  }
}
