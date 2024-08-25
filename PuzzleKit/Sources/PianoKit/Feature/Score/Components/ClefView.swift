//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct ClefView: View {
    var body: some View {
        Image(
            uiImage: ImageRenderer(
                content: Text("𝄞")
                    .font(.largeTitle)
                    .padding(.vertical, -6)
                    .offset(y: -3)
                ).uiImage!
            )
            .resizable()
            .scaledToFit()
    }
}

#Preview {
    ClefView()
        .frame(height: 100)
}
