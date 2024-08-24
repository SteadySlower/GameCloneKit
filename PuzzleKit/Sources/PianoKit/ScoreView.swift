//
//  File.swift
//  
//
//  Created by JW Moon on 8/24/24.
//

import SwiftUI

public struct ScoreView: View {
    
    private let height: CGFloat = 100
    
    public var body: some View {
        ZStack {
            ZStack(alignment: .leading) {
                StaffView()
                
                HStack {
                    ClefView()
                    KeySignatureView(
                        keySignature: .flat,
                        numberOfKeySignature: 2
                    )
                }
            }

            
            // 음표 추가 (4분음표 예시)
            NoteView()
                .offset(x: 50, y: -30)
        }
        .frame(height: height)
    }
}

private struct StaffView: View {
    var body: some View {
        VStack {
            ForEach(0..<5) { i in
                Rectangle()
                    .frame(height: 1)
                if i < 4 {
                    Spacer()
                }
            }
        }
    }
}

private struct ClefView: View {
    var body: some View {
        Image(uiImage: ImageRenderer(content: Text("𝄞").font(.largeTitle)).uiImage!)
            .resizable()
            .scaledToFit()
    }
}

enum KeySignature {
    case sharp, flat
    
    var sign: String {
        switch self {
        case .sharp:
            return "♯"
        case .flat:
            return "♭"
        }
    }
    
    var positionCoefficient: [CGFloat] {
        switch self {
        case .sharp:
            return [-4, -1, -5, -2, 1, -3, 0]
        case .flat:
            return [0, -3, 1, -2, 2, -1, 3]
        }
    }
}

private struct KeySignatureView: View {
    
    /*
     샵의 경우: 파-도-솔-레-라-미-시
     플랫의 경우: 시-미-라-레-솔-도-파
     */
    
    let keySignature: KeySignature
    let numberOfKeySignature: Int
    
    var body: some View {
        GeometryReader { proxy in
            let gapBetweenSemitone = proxy.size.height / 9
            HStack(spacing: -10) {
                ForEach(0..<numberOfKeySignature, id: \.self) { i in
                    Text(keySignature.sign)
                        .font(.system(size: 55))
                        .frame(maxHeight: .infinity)
                        .padding(.vertical, -15)
                        .offset(y: gapBetweenSemitone * keySignature.positionCoefficient[i])
                }
            }
        }
    }
}

private struct NoteView: View {
    var body: some View {
        VStack {
            // 4분음표
            Text("♪")
                .font(.system(size: 50))
        }
    }
}


#Preview {
    ScoreView()
}
