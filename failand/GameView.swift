//
//  GameView.swift
//  failand
//
//  Created by 선애 on 4/15/25.
//
// 게임이 표시되는 화면(View) 관리

import SwiftUI
import SpriteKit

struct GameView: View {
    let gameScene = GameScene(fileNamed: "GameScene") ?? GameScene(size: UIScreen.main.bounds.size)
    
    var body: some View {
        ZStack {
            SpriteView(scene: gameScene)
                .ignoresSafeArea() // 노치랑 홈 인디케이터까지 전부 씬을 덮기
            
            HStack {
                Button("왼쪽") {
                    gameScene.movePlayer(isMovingRight: false)
                }
                
                Button("오른쪽") {
                    gameScene.movePlayer(isMovingRight: true)
                }
                
                Spacer()
            }
        }
    }
}
