//
//  GameScene.swift
//  failand
//
//  Created by 선애 on 4/15/25.
//
// 게임이 실제로 그려지고, 움직이고, 터치에 반응하는 곳

import SpriteKit
//import GameplayKit
import CoreMotion

struct GameElements {
    static var playerOpacity: CGFloat = 0.1
    static var enemySpeed: CGFloat = 1.0
}

struct PhysicsCategory {
    // category masks
    static let none: UInt32 = 0
    static let player: UInt32 = 0x1 << 0
    static let enemy: UInt32 = 0x1 << 1
    static let tile: UInt32 = 0x1 << 2
    static let goal: UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    private var helloLabel: SKLabelNode?
    private var spinnyNode: SKShapeNode?
    
    private var player: SKSpriteNode!
    private var enemy: SKSpriteNode!
    private var tile: SKSpriteNode!
    private var goal: SKSpriteNode!
    
    private var completeLabel: SKLabelNode!
    
    private var isCompleted: Bool = false
    private var playerOriginPosition = CGPoint.zero
    
    private var failCount = 0
    
    let minAcceleration: CGFloat = 0.4
    let motionManager = CMMotionManager()
    
    
    override func didMove(to view: SKView) {
        // 이 씬이 화면에 처음 표시될 때 실행되는 코드
        
        self.physicsWorld.contactDelegate = self
        
        view.showsFPS = true
        view.showsNodeCount = true
        
        self.player = self.childNode(withName: "//player") as? SKSpriteNode
        if let player = self.player {
            player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
            player.physicsBody?.isDynamic = true  // 움직임 허용
//            player.physicsBody?.allowsRotation = false  // 캐릭터가 회전하지 않게
            player.physicsBody?.categoryBitMask = PhysicsCategory.player
            player.physicsBody?.collisionBitMask = PhysicsCategory.tile
            player.physicsBody?.contactTestBitMask =  PhysicsCategory.enemy | PhysicsCategory.tile | PhysicsCategory.goal
            
            playerOriginPosition = player.position
            print("Player 초기 위치: \(playerOriginPosition)")
            
            player.alpha = GameElements.playerOpacity
        }
        
//        self.enemy = self.childNode(withName: "//enemy") as? SKSpriteNode
//        if let enemy = self.enemy {
//            enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.size)
//            enemy.physicsBody?.isDynamic = true  // 움직임 허용
//            enemy.physicsBody?.affectedByGravity = false  // 중력 영향 없음
//            enemy.physicsBody?.allowsRotation = false  // 캐릭터가 회전하지 않게
//            enemy.physicsBody?.categoryBitMask = PhysicsCategory.enemy
//            enemy.physicsBody?.collisionBitMask = playerCategory
//        }
        
        self.enumerateChildNodes(withName: "//tile") { (node, _) in
            if let tile = node as? SKSpriteNode {
                tile.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
                tile.physicsBody?.isDynamic = false  // 움직이지 않음
                tile.physicsBody?.affectedByGravity = false  // 중력 영향 없음
                tile.physicsBody?.categoryBitMask = PhysicsCategory.tile
                tile.physicsBody?.collisionBitMask = PhysicsCategory.player | PhysicsCategory.enemy
                tile.physicsBody?.contactTestBitMask =  PhysicsCategory.player | PhysicsCategory.enemy
            }
        }

        self.goal = self.childNode(withName: "//goal") as? SKSpriteNode
        if let goal = self.goal {
            goal.physicsBody = SKPhysicsBody(rectangleOf: goal.size)
            goal.physicsBody?.isDynamic = false  // 움직이지 않음
            goal.physicsBody?.categoryBitMask = PhysicsCategory.goal
            goal.physicsBody?.collisionBitMask = PhysicsCategory.none // 통과
            goal.physicsBody?.contactTestBitMask = PhysicsCategory.player
        }
        
        // Get label node from scene and store it for use later
        self.helloLabel = self.childNode(withName: "//helloLabel") as? SKLabelNode
        if let helloLabel = self.helloLabel {
            helloLabel.alpha = 0.0
            helloLabel.run(SKAction.fadeIn(withDuration: 2.0))
        }
        
        self.completeLabel = self.childNode(withName: "//completeLabel") as? SKLabelNode
        if let completeLabel = self.completeLabel {
            completeLabel.alpha = 0.0
        }
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        
        
        spawnEnemy()
        setupAccelerometer()
    }
    
    
    func completeTest() {
        if let completeLabel = self.completeLabel {
            completeLabel.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 화면을 터치했을 때 실행
        if let helloLabel = self.helloLabel {
            helloLabel.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
        }
        
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        self.enumerateChildNodes(withName: "//enemy") { (node, _) in
            if let enemy = node as? Enemy {
                enemy.move()
            }
        }
        
        if (motionManager.isAccelerometerAvailable && !isCompleted) {
            if let accelerometerData = motionManager.accelerometerData {
                // x축 가속도 값을 이용하여 좌우 이동 결정
                // iOS에서 y축: 왼쪽이 +, 오른쪽이 - (가로모드라서 y축 사용)
                let acceleration = CGFloat(accelerometerData.acceleration.y)
                
                // 가속도 값에 따라 플레이어 이동
                if abs(acceleration) > minAcceleration {
                    movePlayerWithAcceleration(acceleration)
                }
            }
        }
    }
    
    func spawnEnemy() {
        self.enumerateChildNodes(withName: "//enemy") { (node, _) in
            if let spriteNode = node as? SKSpriteNode {
                let enemy = Enemy(texture: spriteNode.texture, color: spriteNode.color, size: spriteNode.size)
                
                enemy.position = spriteNode.position
                enemy.zPosition = spriteNode.zPosition
                enemy.name = "enemy" // name 설정 - 나중에 검색 가능하도록
                
                enemy.setPhysics()
                
                // 기존 노드를 새 Enemy 객체로 교체
                spriteNode.removeFromParent()
                self.addChild(enemy)
            }
        }
        
    }
    
    func updateGameElements() {
        // failCount에 따른 player 투명도 조절
        GameElements.playerOpacity = min(1.0 , 0.1 + 0.1*CGFloat(failCount))
        player.alpha = GameElements.playerOpacity
        
        // failCount에 따른 enemy 이동 속도 조절
        self.enumerateChildNodes(withName: "//enemy") { (node, _) in
            if let enemy = node as? Enemy {
                enemy.moveAmount = max(0.1 , 2.0 - 0.1*CGFloat(self.failCount))
            }
        }
        
        print(GameElements.playerOpacity, max(0.1 , 2.0 - 0.1*CGFloat(self.failCount)))
    }
    
    func setupAccelerometer() {
        // 가속도계를 사용할 수 있는지 확인
        if motionManager.isAccelerometerAvailable {
            // 업데이트 간격 설정 (초당 업데이트 횟수)
            motionManager.accelerometerUpdateInterval = 1.0 / 60.0
            
            // 가속도계 업데이트 시작
            motionManager.startAccelerometerUpdates()
        }
    }
    
    func movePlayerWithAcceleration(_ acceleration: CGFloat) {
        print("now moving")
        print(acceleration)
        
        let moveAmount: CGFloat = 0.8
        let dx: CGFloat
        
        let orientation = UIDevice.current.orientation
        let directionMultiplier: CGFloat = (orientation == .landscapeRight) ? 1 : -1
        dx = (acceleration > 0) ? moveAmount * directionMultiplier : -moveAmount * directionMultiplier
        
        let moveAction = SKAction.moveBy(x: dx, y: 0, duration: 0.2)
        player.run(moveAction)
    }
    
    func movePlayer(isMovingRight: Bool) {
        let moveAmount: CGFloat = 20
        let dx: CGFloat = isMovingRight ? moveAmount: -moveAmount
        let moveAction = SKAction.moveBy(x: dx, y: 0, duration: 0.2)
        player.run(moveAction)
    }
    
    func replacePlayerOriginPosition() {
        let moveAction = SKAction.move(to: playerOriginPosition, duration: 0.1)
            player.run(moveAction)
    }
    
    func isGameCompleted() {
        isCompleted = true
        completeLabel.run(SKAction.fadeIn(withDuration: 2.0))
        
        motionManager.stopAccelerometerUpdates() // 가속도계 사용 중지
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        // 충돌 처리
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        let currentTime = Date().timeIntervalSince1970
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if (firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.enemy) && (!isCompleted) {
            failCount += 1
            print("Hit!")
            print(failCount)
            
            replacePlayerOriginPosition() // player 원래 위치로 이동
            updateGameElements() // failCount 변화에 따른 요소 제어
        }
        
        if (firstBody.categoryBitMask == PhysicsCategory.enemy && secondBody.categoryBitMask == PhysicsCategory.tile) ||
            (firstBody.categoryBitMask == PhysicsCategory.tile && secondBody.categoryBitMask == PhysicsCategory.enemy) {
            if let enemy = firstBody.node as? Enemy {
                enemy.reverseDirection(currentTime: currentTime)
            }
        }
        
        if firstBody.categoryBitMask == PhysicsCategory.player && secondBody.categoryBitMask == PhysicsCategory.goal {
            isGameCompleted()
        }
        
//        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
//
//        if collision == PhysicsCategory.enemy | PhysicsCategory.tile {
//            if (contact.bodyA.categoryBitMask == PhysicsCategory.enemy) {
//                if let enemy = contact.bodyA.node as? Enemy{
//                enemy.reverseDirection()
//                }
//            }
//            else if (contact.bodyB.categoryBitMask == PhysicsCategory.enemy) {
//                if let enemy = contact.bodyB.node as? Enemy{
//                enemy.reverseDirection()
//                }
//            }
//            else {
//                print("Something wrong!")
//            }
//        }
    }
}

class Enemy: SKSpriteNode {
    var isMovingRight = false
    var moveAmount: CGFloat = 2.0
    
    var reverseLastTime: TimeInterval = 0
    let reverseCoolDownTime: TimeInterval = 0.5
    
    func setPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true  // 움직임 허용
        self.physicsBody?.affectedByGravity = false  // 중력 영향 없음
        self.physicsBody?.allowsRotation = false  // 캐릭터가 회전하지 않게
        self.physicsBody?.categoryBitMask = PhysicsCategory.enemy
        self.physicsBody?.collisionBitMask = PhysicsCategory.none
        self.physicsBody?.contactTestBitMask =  PhysicsCategory.player | PhysicsCategory.tile
    }
    
    func move() {
        let dx: CGFloat = isMovingRight ? moveAmount: -moveAmount
        self.position.x += dx
    }
    
    func reverseDirection(currentTime: TimeInterval) {
        if currentTime - reverseLastTime > reverseCoolDownTime {
            isMovingRight = !isMovingRight
            self.xScale = isMovingRight ? abs(self.xScale) : -abs(self.xScale)
            
            reverseLastTime = currentTime
            
            print("Enemy hit tile: Success")
        } else {
            print("Enemy hit tile: Fail - Cool Down Time")
        }
    }
}
