//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import XCPlayground

let sceneView = SKView(frame: CGRect(x: 0, y: 0, width: 480, height: 320))
let scene = SKScene(size: CGSize(width: 480, height: 320))
scene.physicsBody = SKPhysicsBody(edgeLoopFromRect: scene.frame)
sceneView.showsFPS = true
sceneView.presentScene(scene)
scene.physicsWorld.gravity = CGVector(dx: 0, dy: 0)

XCPShowView("My View", view: sceneView)

let square = SKSpriteNode(imageNamed: "square")
square.name = "shape"
square.position = CGPoint(x: scene.size.width * 0.25, y: scene.size.height * 0.5)

let circle = SKSpriteNode(imageNamed: "circle")
circle.name = "shape"
circle.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.5)

let triangle = SKSpriteNode(imageNamed: "triangle")
triangle.name = "shape"
triangle.position = CGPoint(x: scene.size.width * 0.75, y: scene.size.height * 0.5)

scene.addChild(square)
scene.addChild(circle)
scene.addChild(triangle)

circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width / 2)
square.physicsBody = SKPhysicsBody(rectangleOfSize: square.frame.size)
circle.physicsBody!.dynamic = false

let trianglePath = CGPathCreateMutable()
CGPathMoveToPoint(trianglePath, nil, -triangle.size.width / 2, -triangle.size.height / 2)
CGPathAddLineToPoint(trianglePath, nil, triangle.size.width / 2, -triangle.size.height / 2)
CGPathAddLineToPoint(trianglePath, nil, 0, triangle.size.height / 2)
CGPathAddLineToPoint(trianglePath, nil, -triangle.size.width / 2, -triangle.size.height / 2)
triangle.physicsBody = SKPhysicsBody(polygonFromPath: trianglePath)

func spawnSand() {
  let sand = SKSpriteNode(imageNamed: "sand")
  sand.position = CGPoint(x: random(min: 0, max: scene.size.width), y: random(min: 0, max: scene.size.height - sand.size.height))
  sand.physicsBody = SKPhysicsBody(circleOfRadius: sand.size.width / 2)
  sand.physicsBody?.restitution = 1.0
  sand.physicsBody?.density = 20.0
  sand.name = "sand"
  scene.addChild(sand)
}

func shake() {
  scene.enumerateChildNodesWithName("sand", usingBlock: { sand, _ in
    
    sand.physicsBody?.applyImpulse(CGVector(dx: 0, dy: random(min: 20, max: 40)))
  })
}
var blowingRight = true
var windForce = CGVector(dx: 50, dy: 0)

NSTimer.scheduledTimerWithTimeInterval(0.05, target: scene, selector: #selector(scene.windWithTimer), userInfo: nil, repeats: true)

NSTimer.scheduledTimerWithTimeInterval(3.0, target: scene, selector: #selector(scene.switchWindDirection(_:)), userInfo: nil, repeats: true)



extension SKScene {
  func windWithTimer() {
    enumerateChildNodesWithName("sand") { (sand, _) in
      sand.physicsBody?.applyForce(windForce)
    }
    
    enumerateChildNodesWithName("shape", usingBlock: { shape, _ in
      shape.physicsBody?.applyForce(windForce)
    })
  }
  
  func switchWindDirection(timer: NSTimer) {
    blowingRight = !blowingRight
    windForce = CGVector(dx: blowingRight ? -50 : 50, dy: 0)
  }
}

let l = SKSpriteNode(imageNamed: "L")
l.position = CGPoint(x: scene.size.width * 0.5, y: scene.size.height * 0.75)
l.physicsBody = SKPhysicsBody(texture: l.texture!, size: l.size)
scene.addChild(l)

delay(seconds: 2.0, completion: {
  scene.physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
  scene.runAction(
    SKAction.repeatAction(
      SKAction.sequence([
        SKAction.runBlock(spawnSand),
        SKAction.waitForDuration(0.1)
        ]),
      count: 100)
  )
})

let circleMove = SKAction.repeatActionForever(SKAction.sequence([
  SKAction.moveToX(50, duration: 3.0),
  SKAction.moveToX(400.0, duration: 3.0)
  ]))
circle.runAction(circleMove)
