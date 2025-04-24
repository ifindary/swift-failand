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
        VStack{
            Text("Let's celebrate!")
                .font(.pressStart24)
                .padding(.top, 50)
                .padding(.bottom, 41)
            
            Text("You've achieved success")
                .font(.pressStart16)
                .multilineTextAlignment(.center)
                .padding(.bottom, 16)
            Text("through \(failCount) failures. Amazing!")
                .font(.pressStart16)
                .multilineTextAlignment(.center)
                .padding(.bottom, 43)
            
            HStack(spacing: 50) {
                ImageButton(imageName: "HomeButton", action: {
                    gameScene.resetFailCount()
                    currentGameState = .home
                })
                
                ImageButton(imageName: "RetryButton", action: {
                    gameScene.resetFailCount()
                    currentGameState = .loading
                })
            }
        }
    }
}
