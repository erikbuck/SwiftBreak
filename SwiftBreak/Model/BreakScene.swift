//
//  BreakScene.swift
//  SwiftBreak
//
//  Created by wsucatslabs on 10/15/21.
//

import SpriteKit
import GameplayKit

class BreakScene: SKScene, SKPhysicsContactDelegate {
   
   private var paddle = SKSpriteNode()
   private var ball = SKSpriteNode()
   private var ballStartPosition = CGPoint(x: 0, y: 0)
   
   override func didMove(to view: SKView) {
      paddle = self.childNode(withName: "Paddle") as! SKSpriteNode
      ball = self.childNode(withName: "Ball") as! SKSpriteNode
      ballStartPosition = ball.position
      ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
      physicsWorld.contactDelegate = self
   }
   
   func touchMoved(toPoint pos : CGPoint) {
      paddle.position = CGPoint(x:pos.x, y:paddle.position.y)
   }
   
   func resetBall() {
      self.addChild(ball)
      ball.position = ballStartPosition
      ball.physicsBody!.velocity = CGVector(dx: 0, dy: 0)
   }
   
   func removeBrick(brick : SKNode) {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
         brick.removeFromParent()
      }
   }
   
   func didBegin(_ contact: SKPhysicsContact) {
      if contact.bodyA.node?.name == nil {
         removeBrick(brick: contact.bodyA.node!)
      } else if contact.bodyB.node?.name == nil {
         removeBrick(brick: contact.bodyB.node!)
      } else if(contact.bodyA.node?.name == "Bottom" ||
                contact.bodyB.node?.name == "Bottom") {
         ball.removeFromParent()
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.resetBall()
         }
      }
   }
}
