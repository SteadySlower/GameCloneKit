//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct WhiteKeysView: View {
    
    let whiteKeys: [String] = ["도", "레", "미", "파", "솔", "라", "시"]
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(whiteKeys, id: \.self) { key in
                WhiteKeyView(name: key)
            }
        }
    }
}

private struct WhiteKeyView: View {
    let name: String
    
    var body: some View {
        Rectangle()
            .fill(Color.white)
            .border(Color.black, width: 1)
            .overlay(
                Text(name)
                    .foregroundColor(.black)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 10)
            )
    }
}

#Preview {
    WhiteKeysView()
        .frame(height: 200)
}
