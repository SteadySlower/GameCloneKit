//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct BlackKeysView: View {
    
    let blackKeys: [String] = ["도#", "레#", "파#", "솔#", "라#"]
    
    var body: some View {
        GeometryReader { proxy in
            let whiteKeyWidth = proxy.size.width / 7
            let blackKeyWidth = whiteKeyWidth / 2
            let blackKeyHeight = proxy.size.height * 0.7
            HStack(spacing: 0) {
                Spacer()
                    .frame(width: whiteKeyWidth * 0.75)
                ForEach(blackKeys, id: \.self) { key in
                    BlackKeyView(name: key)
                        .frame(width: blackKeyWidth, height: blackKeyHeight)
                    Spacer()
                        .frame(width: key != "레#" ? whiteKeyWidth / 2 : whiteKeyWidth * 1.5)
                }
                Spacer()
                    .frame(width: whiteKeyWidth / 2)
            }
        }
    }
    
}


private struct BlackKeyView: View {
    let name: String

    var body: some View {
        Rectangle()
            .fill(Color.black)
            .cornerRadius(5)
            .overlay(
                Text(name)
                    .foregroundColor(.white)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
            )
    }
}

#Preview {
    ZStack {
        WhiteKeysView()
        BlackKeysView()
    }
    .frame(height: 200)
}
