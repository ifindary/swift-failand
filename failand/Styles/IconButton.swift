//
//  IconButton.swift
//  failand
//
//  Created by 선애 on 4/22/25.
//

import SwiftUI

struct IconButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .renderingMode(.template) // 다크 모드 대응
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
                .foregroundColor(Color("TextColor"))
        }
    }
}
