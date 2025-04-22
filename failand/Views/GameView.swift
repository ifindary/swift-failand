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
    @Binding var currentGameState: GameState
    
    @State private var gameScene: GameScene?
    @State private var isClear = false
    
    @AppStorage("failCount") var failCount: Int = 0
    
    var body: some View {
        ZStack {
            if let scene = gameScene {
                SpriteView(scene: scene)
                    .ignoresSafeArea() // 노치랑 홈 인디케이터까지 전부 씬을 덮기
            }
            
            VStack {
                HStack {
                    IconButton(imageName: "BackButton", action: {
                        removeScene()
                        
                        if (failCount <= 0) {
                            currentGameState = .home
                        } else {
                            currentGameState = .record
                        }
                    })
                    .font(.pressStart16)
                    .padding()
                    
                    Spacer()
                    
                    // for testing
//                    Button("Reset") {
//                        gameScene?.resetFailCount()
//                    }
//                    .font(.pressStart16)
                    
                    Text("Fail : \(failCount)")
                        .font(.pressStart16)
                        .foregroundColor(.black)
                        .padding()
                }
                
                Spacer()
            }
            
        }
        .onAppear {
            createScene()
        }
//        .onDisappear {
//            removeScene()
//        }
        .onChange(of: isClear) {
            if isClear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    currentGameState = .result
                }
            }
        }
    }
    
    private func createScene() {
        gameScene = GameScene(fileNamed: "GameScene") ?? GameScene(size: UIScreen.main.bounds.size)
        
        gameScene?.clearHandler = {
            isClear = true
        }
    }

    private func removeScene() {
        gameScene?.isPaused = true
        gameScene?.removeAllChildren()
    }
}
