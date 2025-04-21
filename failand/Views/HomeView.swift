//
//  HomeView.swift
//  failand
//
//  Created by 선애 on 4/21/25.
//

import SwiftUI

struct HomeView: View {
    @Binding var currentGameState: GameState
    
    @AppStorage("failCount") var failCount: Int = 0
    
    var body: some View {
        VStack{
            Text("Failand")
                .font(.largeTitle)
            
            Button("Press to Start") {
                if (failCount <= 0) {
                    currentGameState = .gameplay
                } else {
                    currentGameState = .record
                }
            }
            .padding()
            .foregroundColor(.black)
        }
    }
}
