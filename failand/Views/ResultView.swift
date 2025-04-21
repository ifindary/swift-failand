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
    
    var body: some View {
        VStack{
            Text("Failand")
                .font(.largeTitle)
            
            Text("You did it! Amazing!")
            
            HStack {
                Button("Home") {
                    gameScene.resetFailCount()
                    currentGameState = .home
                }
                .padding()
                .foregroundColor(.black)
                
                Button("Retry") {
                    gameScene.resetFailCount()
                    currentGameState = .gameplay
                }
                .padding()
                .foregroundColor(.black)
            }
        }
    }
}
