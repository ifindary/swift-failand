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
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd.E HH:mm"
        return formatter.string(from: lastPlayDate)
    }
    
    var body: some View {
        ZStack {
            HStack {
                VStack{
                    IconButton(imageName: "BackButton", action: {
                        currentGameState = .home
                    })
                    
                    Spacer()
                }
                .padding()
                
                Spacer()
            }
            
            VStack {
                Text("Last Play")
                    .font(.pressStart24)
                    .padding(26)
                
                Spacer()
                
                Text(formattedDate)
                    .font(.pressStart16)
                    .padding(.bottom, 16)
                Text("Fail Count : \(failCount)")
                    .font(.pressStart16)
                    .padding(.bottom, 40)
                
                HStack {
                    ImageButton(imageName: "NewButton", action: {
                        gameScene.resetFailCount()
                        currentGameState = .loading
                    })
                    .padding()
                    .foregroundColor(.black)
                    
                    ImageButton(imageName: "ContinueButton", action: {
                        currentGameState = .loading
                    })
                    .padding()
                    .foregroundColor(.black)
                }
                
                Spacer()
            }
        }
    }
}
