//
//  GameScene.swift
//  Project11
//
//  Created by Gleb on 22.08.2018.
//  Copyright © 2018 Gleb Maltsev. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {

  private var scoreLabel: SKLabelNode!

  private var score: Int = 0 {
    didSet {
      scoreLabel.text = "Score: \(score)"
    }
  }

  private var editLabel: SKLabelNode!

  private var editingMode: Bool = true {
    didSet {
      editLabel.text = editingMode ? "Edit" : "Done"
    }
  }

  override func didMove(to view: SKView) {
    let background = SKSpriteNode(imageNamed: "background.jpg")
    background.position = CGPoint(x: 512, y: 384)
    background.blendMode = .replace
    background.zPosition = -1
    addChild(background)
    physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    physicsWorld.contactDelegate = self

    makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
    makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
    makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
    makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)

    for i in stride(from: 0, to: 1280, by: 256) {
      makeBouncer(at: CGPoint(x: i, y: 0))
    }

    scoreLabel = SKLabelNode(fontNamed: "ChalkDuster")
    scoreLabel.text = "Score: 0"
    scoreLabel.horizontalAlignmentMode = .right
    scoreLabel.position = CGPoint(x: 980, y: 700)
    addChild(scoreLabel)

    editLabel = SKLabelNode(fontNamed: "Chalkduster")
    editLabel.text = "Edit"
    editLabel.position = CGPoint(x: 80, y: 700)
    addChild(editLabel)
  }

  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    if let touch = touches.first {
      let location = touch.location(in: self)
      let objects = nodes(at: location)
      if objects.contains(editLabel) {
        editingMode = !editingMode
      } else {
        if editingMode {
          let size = CGSize(width: GKRandomDistribution(lowestValue: 16, highestValue: 128).nextInt(),
                            height: 16)
          let box = SKSpriteNode(color: RandomColor(), size: size)
          box.zRotation = RandomCGFloat(min: 0, max: 3)
          box.position = location

          box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
          box.physicsBody!.isDynamic = false

          addChild(box)
        } else {
          let ball = SKSpriteNode(imageNamed: "ballRed")
          ball.name = "ball"
          ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
          ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask
          ball.physicsBody!.restitution = 0.8
          ball.position = location
          addChild(ball)
        }
      }
    }
  }

  private func collisionBetween(ball: SKNode, object: SKNode) {
    if object.name == "good" {
      destroy(ball: ball)
      score += 1
    } else if object.name == "bad" {
      destroy(ball: ball)
      score -= 1
    }
  }

  private func destroy(ball: SKNode) {
    ball.removeFromParent()
  }

  func didBegin(_ contact: SKPhysicsContact) {
    if contact.bodyA.node?.name == "ball" {
      collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
    } else if contact.bodyB.node?.name == "ball" {
      collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
    }
  }

  private func makeSlot(at position: CGPoint, isGood: Bool) {
    let slotName = isGood ? "good" : "bad"
    let baseSlotImage = isGood ? "slotBaseGood" : "slotBaseBad"
    let glowSlotImage = isGood ? "slotGlowGood" : "slotGlowBad"
    let slotBase = SKSpriteNode(imageNamed: baseSlotImage)
    let slotGlow = SKSpriteNode(imageNamed: glowSlotImage)

    slotBase.position = position
    slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
    slotBase.physicsBody!.isDynamic = false
    slotBase.name = slotName

    slotGlow.position = position
    slotGlow.name = slotName

    addChild(slotBase)
    addChild(slotGlow)

    let spin = SKAction.rotate(byAngle: CGFloat.pi, duration: 10)
    let spinForever = SKAction.repeatForever(spin)
    slotGlow.run(spinForever)
  }

  private func makeBouncer(at position: CGPoint) {
    let bouncer = SKSpriteNode(imageNamed: "bouncer")
    bouncer.position = position
    bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
    bouncer.physicsBody!.isDynamic = false
    addChild(bouncer)
  }
}
