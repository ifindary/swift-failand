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
    
    @State private var offsetX: CGFloat = 0
    @State private var angle: Double = 0
    @State private var isFlipped: Bool = false
    @State private var isMovingRight: Bool = true
    
    var body: some View {
        VStack{
            Image("GameTitle")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 70)
                .foregroundColor(Color("TextColor"))
                .padding(.top, 80)
                .padding(.bottom, 45)
                .scaleEffect(titleScale)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: titleScale)
                .onAppear {
                    titleScale = 1.05
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
            .padding(.bottom, 30)
            .opacity(isButtonVisible ? 1 : 0.01)
            .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isButtonVisible)
            .onAppear {
                isButtonVisible.toggle()
            }
            
            Image("Player")
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 42)
                .foregroundColor(Color("TextColor"))
                .scaleEffect(x: isFlipped ? -1 : 1, y: 1)
                .rotationEffect(.degrees(angle))
                .offset(x: offsetX)
                .onAppear {
                    movePlayer()
                }
                .padding(.bottom, -10)
            
            Rectangle()
                .fill(Color("TextColor"))
                .frame(maxWidth: .infinity, maxHeight: 6)
                .edgesIgnoringSafeArea(.horizontal)
        }
    }
    
    func movePlayer() {
        let screenWidth = UIScreen.main.bounds.width
        
        Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            if isMovingRight {
                angle += 4
                offsetX += 2
                if offsetX >= (screenWidth/2) + 300 {
                    isMovingRight = false
                    isFlipped = true
                }
            } else {
                angle -= 4
                offsetX -= 2
                if offsetX <= -(screenWidth/2) - 300 {
                    isMovingRight = true
                    isFlipped = false
                }
            }
        }
    }
}
