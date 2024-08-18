//
//  SwiftUIView.swift
//  
//
//  Created by JW Moon on 8/17/24.
//

import SwiftUI

struct PuzzleBoard: View {
    
    @State var location: CGPoint = .zero
    @State var nowColor: Color? = nil
    
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
                        .background { dragDetector(for: entry) }
                }
            }
            .border(.black)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { val in
                        self.location = val.location
                    }
                    .onEnded { val in
                        self.location = .zero
                        self.nowColor = nil
                        self.selectedId = []
                    }
            )
        }
    }
    
    private func dragDetector(for entry: PuzzleCellEntry) -> some View {
        GeometryReader { proxy in
            let frame = proxy.frame(in: .global)
            let isDragLocationInsideFrame = frame.contains(location)
            Color.clear
                .onChange(of: isDragLocationInsideFrame) { oldVal, newVal in
                    guard newVal else { return }
                    if selectedId.isEmpty {
                        self.selectedId.append(entry.id)
                        self.nowColor = entry.color
                    } else if nowColor == entry.color {
                        self.selectedId.append(entry.id)
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
