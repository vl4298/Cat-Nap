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
  static let Edge: UInt32 = 0b1000
  static let Label: UInt32 = 0b10000
}

class GameScene: SKScene {
  
  var bedNode: BedNode!
  var catNode: CatNode!
  var playable = true
  
  override func didMoveToView(view: SKView) {
    /* Setup your scene here */
    
    let maxAspectRatio: CGFloat = 16.0 / 9.0
    let maxAspectHeight: CGFloat = size.width / maxAspectRatio
    let playableMargin: CGFloat = (size.height - maxAspectHeight) / 2.0
    
    let playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: size.height - playableMargin * 2)
    physicsBody = SKPhysicsBody(edgeLoopFromRect: playableRect)
    physicsWorld.contactDelegate = self
    physicsBody?.categoryBitMask = PhysicsCateGory.Edge
    
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

extension GameScene: SKPhysicsContactDelegate {
  
  func inGameMessage(text: String) {
    let message = MessageNode(message: "Try Again")
    message.position = CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame))
    addChild(message)
  }
  
  func newGame() {
    let scene = GameScene(fileNamed: "GameScene")
    scene?.scaleMode = scaleMode
    view?.presentScene(scene)
  }
  
  func lose() {
    SKTAudio.sharedInstance().pauseBackgroundMusic()
    runAction(SKAction.playSoundFileNamed("lose.mp3", waitForCompletion: false))
    inGameMessage("Try Again...")
    performSelector(#selector(newGame), withObject: nil, afterDelay: 5)
  }
  
  func didBeginContact(contact: SKPhysicsContact) {
    if !playable {
      return
    }
    
    let contact = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
    
    if contact == PhysicsCateGory.Cat | PhysicsCateGory.Bed {
      print("SUCCESS")
    } else {
      playable = false
      lose()
    }
  }
  
  func didEndContact(contact: SKPhysicsContact) {
    //
  }
}
