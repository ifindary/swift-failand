//
//  RecordView.swift
//  failand
//
//  Created by 선애 on 4/21/25.
//

import SwiftUI

struct RecordView: View {
    @Binding var currentGameState: GameState

    let gameScene = GameScene(fileNamed: "GameScene") ?? GameScene(size: UIScreen.main.bounds.size)
    
    @AppStorage("failCount") var failCount: Int = 0
    @AppStorage("lastPlayDate") var lastPlayDate: Date = Date()
    
    @State private var buttonOpacity = 0.0
    
    var body: some View {
        ZStack {
            HStack {
                VStack{
                    Button("Back") {
                        currentGameState = .home
                    }
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
            
            VStack {
                Text("Last Play")
                    .font(.largeTitle)
                    .padding()
                
                
                Spacer()
                
                Text("Date : \(lastPlayDate)")
                Text("Fail Count : \(failCount)")
                
                HStack {
                    Button("New") {
                        gameScene.resetFailCount()
                        currentGameState = .gameplay
                    }
                    .padding()
                    .foregroundColor(.black)
                    
                    Button("Continue") {
                        currentGameState = .gameplay
                    }
                    .padding()
                    .foregroundColor(.black)
                }
                .opacity(buttonOpacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.0)) {
                    buttonOpacity = 1.0
                    }
                }
                
                Spacer()
            }
        }
    }
}
