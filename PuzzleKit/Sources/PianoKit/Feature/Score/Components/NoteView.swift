//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct NoteView: View {
    
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
    NoteView(note: .도)
        .frame(height: 100)
}
