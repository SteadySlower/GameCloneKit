//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct ClefView: View {
    
    private let sign: String
    
    init(clef: Clef) {
        self.sign = clef == .treble ? "𝄞" : "𝄢"
    }
    
    // TODO: adjust clef size and position in the Staff
    var body: some View {
        Image(
            uiImage: ImageRenderer(
                content: Text(sign)
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
    HStack {
        ClefView(clef: .treble)
        ClefView(clef: .bass)
    }
    .frame(height: 100)

}
