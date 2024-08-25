//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct PianoView: View {
    var body: some View {
        ZStack {
            WhiteKeysView()
            BlackKeysView()
        }
    }
}

#Preview {
    HStack(spacing: 0) {
        PianoView()
        PianoView()
    }
    .frame(height: 200)
}
