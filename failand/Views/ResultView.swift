//
//  ResultView.swift
//  failand
//
//  Created by 선애 on 4/21/25.
//

import SwiftUI

struct ResultView: View {
    @Binding var currentGameState: GameState
    
    let gameScene = GameScene(fileNamed: "GameScene") ?? GameScene(size: UIScreen.main.bounds.size)
    @AppStorage("failCount") var failCount: Int = 0
    
    var body: some View {
        VStack(spacing: 42){
            Text("Let's celebrate")
                .font(.pressStart24)
            
            Text("""
                 You've achieved success
                 through \(failCount) failures. Amazing!
                 """)
                .font(.pressStart16)
                .lineSpacing(10)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 50) {
                IconButton(imageName: "HomeButton", action: {
                    gameScene.resetFailCount()
                    currentGameState = .home
                })
                
                IconButton(imageName: "RetryButton", action: {
                    gameScene.resetFailCount()
                    currentGameState = .home
                })
            }
        }
    }
}
