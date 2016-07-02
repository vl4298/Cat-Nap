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

protocol interactiveNodes {
  func interactive()
}

struct PhysicsCateGory {
  static let None: UInt32 = 0
  static let Cat: UInt32 = 0b1
  static let Block: UInt32 = 0b10
  static let Bed: UInt32 = 0b100
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
    
    SKTAudio.sharedInstance().playBackgroundMusic("backgroundMusic.mp3")
  }
}
