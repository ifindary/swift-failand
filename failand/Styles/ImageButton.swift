//
//  ImageButton.swift
//  failand
//
//  Created by 선애 on 4/22/25.
//

import SwiftUI

struct ImageButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .foregroundColor(Color("TextColor"))
        }
    }
}
