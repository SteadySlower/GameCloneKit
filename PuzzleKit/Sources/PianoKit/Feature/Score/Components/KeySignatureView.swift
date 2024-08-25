//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct KeySignatureView: View {
    
    /*
     샵의 경우: 파-도-솔-레-라-미-시
     플랫의 경우: 시-미-라-레-솔-도-파
     */
    
    private let sign: String
    private let numberOfKeySignature: Int
    private let positionCoefficient: [CGFloat]
    
    init(keySignature: KeySignature, numberOfKeySignature: Int) {
        self.sign = keySignature == .sharp ? "♯" : "♭"
        self.numberOfKeySignature = numberOfKeySignature
        self.positionCoefficient = keySignature == .sharp ? [-4, -1, -5, -2, 1, -3, 0] : [0, -3, 1, -2, 2, -1, 3]
    }
    
    var body: some View {
        GeometryReader { proxy in
            let gapBetweenSemitone = proxy.size.height / 8
            HStack(spacing: -10) {
                ForEach(0..<numberOfKeySignature, id: \.self) { i in
                    Text(sign)
                        .font(.system(size: 55))
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, -15)
                        .offset(y: gapBetweenSemitone * positionCoefficient[i])
                }
            }
        }
        .scaledToFit()
    }
}

#Preview {
    KeySignatureView(keySignature: .sharp, numberOfKeySignature: 3)
        .frame(height: 100)
}
