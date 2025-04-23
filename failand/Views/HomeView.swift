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
    
    @State private var titleScale: CGFloat = 1.0
    @State private var isButtonVisible = true
    
    var body: some View {
        VStack(spacing: 40){
            Text("FAILAND")
                .font(.pressStart48)
                .scaleEffect(titleScale)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: titleScale)
                .onAppear {
                    titleScale = 1.1
                }
            
            Button("Press to Start") {
                if (failCount <= 0) {
                    currentGameState = .loading
                } else {
                    currentGameState = .record
                }
            }
            .font(.pressStart16)
            .foregroundColor(Color("TextColor"))
            .opacity(isButtonVisible ? 1 : 0.01)
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isButtonVisible)
            .onAppear {
                isButtonVisible.toggle()
            }
        }
    }
}
