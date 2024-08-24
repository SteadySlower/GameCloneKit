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
                        numberOfKeySignature: 0
                    )
                    NoteView(note: .도)
                }
            }
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
}

private struct KeySignatureView: View {
    
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

enum Note: Int {
    case 도 = 0, 레, 미, 파, 솔, 라, 시, 높도, 높레, 높미, 높파, 높솔, 높라, 높시
}

private struct NoteView: View {
    
    let note: Note
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size.height / 4
            let gapBetweenSemitone = proxy.size.height / 8
            ZStack {
                Ellipse()
                    .frame(width: size * 1.5, height: size, alignment: .center)
                if note.rawValue < Note.레.rawValue || note.rawValue > Note.높솔.rawValue {
                    Rectangle()
                        .frame(width: size * 2.3, height: 1)
                }
            }
            .offset(y: gapBetweenSemitone * positionCoefficient(of: note))
            .padding(.trailing, proxy.size.width / 3)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    private func positionCoefficient(of note: Note) -> CGFloat {
        6 - CGFloat(note.rawValue)
    }
}


#Preview {
    ScoreView()
}
