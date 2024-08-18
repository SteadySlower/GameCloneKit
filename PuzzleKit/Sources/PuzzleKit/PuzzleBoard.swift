//
//  SwiftUIView.swift
//  
//
//  Created by JW Moon on 8/17/24.
//

import SwiftUI

struct PuzzleBoard: View {
    
    @State var location: CGPoint = .zero
    
    var body: some View {
        VStack {
            Text(location == .zero ? "Not Dragging" : "\(location)")
            Rectangle()
                .frame(width: 300, height: 300)
                .foregroundColor(.white)
                .border(.black)
                .gesture(
                    DragGesture(coordinateSpace: .global)
                        .onChanged { val in
                            self.location = val.location
                        }
                        .onEnded { val in
                            self.location = .zero
                        }
                )
        }
    }
}

#Preview {
    PuzzleBoard()
}
