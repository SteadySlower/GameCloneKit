//
//  SwiftUIView.swift
//  
//
//  Created by JW Moon on 8/17/24.
//

import SwiftUI

struct PuzzleBoard: View {
    
    @State var location: CGPoint = .zero
    
    let colors: [Color] = [.red, .blue, .green, .yellow]
    @State var selectedColors: [Color] = []
    
    let vGridColumns: [GridItem] = [.init(.fixed(100)), .init(.fixed(100))]
    
    var body: some View {
        VStack {
            Text(location == .zero ? "Not Dragging" : "\(location)")
            LazyVGrid(columns: vGridColumns) {
                ForEach(colors, id: \.self) { color in
                    PuzzleCell(color: color, isSelected: selectedColors.contains(color))
                        .background { dragDetector(for: color) }
                }
            }
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
    
    private func dragDetector(for color: Color) -> some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)
            let isDragLocationInsideFrame = frame.contains(location)
            Color.clear
                .onChange(of: isDragLocationInsideFrame) { oldVal, newVal in
                    if newVal {
                        self.selectedColors.append(color)
                    } else {
                        self.selectedColors = selectedColors.filter { $0 != color }
                    }
                }
        }
    }
}

private struct PuzzleCell: View {
    
    let color: Color
    let isSelected: Bool
    
    var body: some View {
        color
            .opacity(isSelected ? 1 : 0.5)
            .frame(width: 100, height: 100)
    }
    
}

#Preview {
    PuzzleBoard()
}
