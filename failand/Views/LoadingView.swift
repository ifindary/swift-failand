//
//  LoadingView.swift
//  failand
//
//  Created by 선애 on 4/23/25.
//

import SwiftUI

struct LoadingView: View {
    @Binding var currentGameState: GameState
    
    @State private var offsetY: CGFloat = 0
    
    @State private var dotCount = 0
    let maxDots = 3
    let timer = Timer.publish(every: 0.4, on: .main, in: .common).autoconnect()

    @State private var currentTip = ""
    let gameTips = [
        "Today’s fail, tomorrow’s fuel",
        "Mission failed? Good. ‘Cause you tried",
        "Every failure is a step closer to success",
        "No failure, no growth"
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Player")
                .renderingMode(.template) // 다크 모드 대응
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundColor(Color("TextColor"))
                .offset(y: offsetY)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: offsetY)
                .onAppear {
                    offsetY = -10
                }
                .padding(.leading, -20)
                .padding(.bottom, 10)
            
            HStack {
                Text("Loading")
                .font(.pressStart24)
                .foregroundColor(Color("TextColor"))
                .padding(.leading, 40)
                
                Text(String(repeating: ".", count: dotCount))
                    .font(.pressStart24)
                    .foregroundColor(Color("TextColor"))
                    .frame(width: 80, alignment: .leading)
                    .onReceive(timer) { _ in
                        dotCount = (dotCount + 1) % (maxDots + 1)
                }
            }
            
            Spacer()
            
            Text(currentTip)
                .font(.pressStart12)
                .foregroundColor(Color("TextColor"))
                .padding(26)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                currentGameState = .gameplay
            }
            currentTip = gameTips.randomElement() ?? gameTips[0]
        }
    }
}
