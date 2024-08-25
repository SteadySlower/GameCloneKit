//
//  File.swift
//  
//
//  Created by JW Moon on 8/25/24.
//

import SwiftUI

struct StaffView: View {
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

#Preview {
    StaffView()
        .frame(height: 100)
}
