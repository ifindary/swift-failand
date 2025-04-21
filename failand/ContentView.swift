//
//  ContentView.swift
//  failand
//
//  Created by 선애 on 4/21/25.
//

import SwiftUI

enum GameState {
    case home
    case record
    case gameplay
    case result
}

struct ContentView: View {
    @State var currentGameState: GameState = .home
    
    var body: some View {
        ZStack{
            switch currentGameState {
            case .home:
                HomeView(currentGameState: $currentGameState)
            case .record:
                RecordView(currentGameState: $currentGameState)
            case .gameplay:
                GameView(currentGameState: $currentGameState)
            case .result:
                ResultView(currentGameState: $currentGameState)
            }
        }
//        .transition(.opacity)
//        .animation(.easeInOut, value: currentGameState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
