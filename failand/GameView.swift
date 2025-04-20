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
    
    @AppStorage("failCount") var failCount: Int = 0
    
    var body: some View {
        ZStack {
            SpriteView(scene: gameScene)
                .ignoresSafeArea() // 노치랑 홈 인디케이터까지 전부 씬을 덮기
            
            VStack {
                HStack {
                    Button("Reset") {
                        UserDefaults.standard.removeObject(forKey: "failCount")
                        gameScene.resetFailCount()
                    }
                    
                    Spacer()
                    
                    Text("Fail : \(failCount)")
                        .foregroundColor(.black)
                        .padding()
                }
                
                Spacer()
            }
            
        }
    }
}
