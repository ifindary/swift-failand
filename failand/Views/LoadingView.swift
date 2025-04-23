//
//  LoadingView.swift
//  failand
//
//  Created by 선애 on 4/23/25.
//

import SwiftUI

struct LoadingView: View {
    @Binding var currentGameState: GameState
    
    @AppStorage("failCount") var failCount: Int = 0
    
    @State private var titleScale: CGFloat = 1.0
    @State private var isButtonVisible = true
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Player")
                .renderingMode(.template) // 다크 모드 대응
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundColor(Color("TextColor"))
                .padding()
            
            Text("Loading...")
                .font(.pressStart24)
                .foregroundColor(Color("TextColor"))
                .opacity(isButtonVisible ? 1 : 0.01)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isButtonVisible)
            
            Spacer()
            
            Text("Do you know that? Failure makes success")
                .font(.pressStart12)
                .foregroundColor(Color("TextColor"))
                .opacity(isButtonVisible ? 1 : 0.01)
                .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isButtonVisible)
                .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                currentGameState = .gameplay
            }
        }
    }
}
