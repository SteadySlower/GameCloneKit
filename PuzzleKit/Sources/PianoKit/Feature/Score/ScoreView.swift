//
//  File.swift
//  
//
//  Created by JW Moon on 8/24/24.
//

import SwiftUI

struct ScoreView: View {
    var body: some View {
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
    }
}

#Preview {
    ScoreView()
        .frame(height: 100)
}
