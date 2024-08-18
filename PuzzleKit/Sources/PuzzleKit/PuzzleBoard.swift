//
//  SwiftUIView.swift
//  
//
//  Created by JW Moon on 8/17/24.
//

import SwiftUI

struct PuzzleBoard: View {
    
    @State var location: CGPoint = .zero
    
    let colors: [PuzzleCellEntry] = {
        let allColors: [Color] = [.yellow, .purple, .blue, .green, .red]
        var result = [PuzzleCellEntry]()
        for i in 0..<100 {
            result.append(.init(id: i, color: allColors.randomElement()!))
        }
        return result
    }()
    
    @State var selectedId: [Int] = []
    
    let vGridColumns: [GridItem] = Array(repeating: GridItem(.fixed(30)), count: 10)
    
    var body: some View {
        VStack {
            LazyVGrid(columns: vGridColumns) {
                ForEach(colors, id: \.id) { entry in
                    PuzzleCell(entry: entry, isSelected: selectedId.contains(entry.id))
                        .background { dragDetector(for: entry.id) }
                }
            }
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
    
    private func dragDetector(for id: Int) -> some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)
            let isDragLocationInsideFrame = frame.contains(location)
            Color.clear
                .onChange(of: isDragLocationInsideFrame) { oldVal, newVal in
                    if newVal {
                        self.selectedId.append(id)
                    } else {
                        self.selectedId = selectedId.filter { $0 != id }
                    }
                }
        }
    }
}

struct PuzzleCellEntry: Identifiable {
    let id: Int
    let color: Color
}

private struct PuzzleCell: View {
    
    let entry: PuzzleCellEntry
    let isSelected: Bool
    
    var body: some View {
        entry.color
            .opacity(isSelected ? 1 : 0.5)
            .frame(width: 30, height: 30)
    }
    
}

#Preview {
    PuzzleBoard()
}
