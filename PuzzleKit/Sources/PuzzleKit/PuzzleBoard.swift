//
//  SwiftUIView.swift
//  
//
//  Created by JW Moon on 8/17/24.
//

import SwiftUI

let allColors: [Color] = [.yellow, .purple, .blue, .green, .red]

struct PuzzleBoard: View {
    
    @State var location: CGPoint = .zero
    @State var nowColor: Color? = nil
    @State var nextIdCandidate: [Int] = []
    @State var score: Int = 0
    
    @State var colors: [PuzzleCellEntry] = {
        var result = [PuzzleCellEntry]()
        for i in 0..<100 {
            result.append(.init(id: i, color: allColors.randomElement()!))
        }
        return result
    }()
    
    @State var selectedId: [Int] = []
    @State var toDistroyId: [Int] = []
    @State var toCreateID: [Int] = []
    
    let vGridColumns: [GridItem] = Array(repeating: GridItem(.fixed(30)), count: 10)
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
            LazyVGrid(columns: vGridColumns) {
                ForEach(colors, id: \.id) { entry in
                    PuzzleCell(
                        entry: entry,
                        status: getCellStatus(entry.id),
                        onDistoryFinished: { onDistoryFinished(entry.id) },
                        onCreatedFinished: {
                            onCreateFinished(entry.id)
                        }
                    )
                    .background { dragDetector(for: entry) }
                    .id("\(entry) \(getCellStatus(entry.id))")
                }
            }
            .border(.black)
            .gesture(
                DragGesture(minimumDistance: 0, coordinateSpace: .global)
                    .onChanged { val in
                        self.location = val.location
                    }
                    .onEnded { val in
                        // handle score
                        if selectedId.count > 2 {
                            self.score += selectedId.count
                            self.toDistroyId.append(contentsOf: selectedId)
                        }
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
                    guard newVal && !selectedId.contains(entry.id) else { return }
                    if selectedId.isEmpty {
                        self.selectedId.append(entry.id)
                        self.nowColor = entry.color
                        self.nextIdCandidate = getPossibleNextId(for: entry.id)
                    } else if nowColor == entry.color && nextIdCandidate.contains(entry.id) {
                        self.selectedId.append(entry.id)
                        self.nextIdCandidate = getPossibleNextId(for: entry.id)
                    }
                }
        }
    }
    
    private func getPossibleNextId(for id: Int) -> [Int] {
        let nexts = [
            id - 11,
            id - 10,
            id - 9,
            id - 1,
            id + 1,
            id + 9,
            id + 10,
            id + 11
        ]
        .filter { next in
            (0..<100).contains(next)
        }
        .filter { next in
            // if cell is on the left edge -> remove left side three cells
            if id % 10 == 0 {
                return ![id - 11, id - 1, id + 9].contains(next)
            // if cell is on the right edge -> remove right side three cells
            } else if id % 10 == 9 {
                return ![id + 1, id + 11, id - 9].contains(next)
            } else {
                return true
            }
        }
        
        return nexts
    }
    
    func getCellStatus(_ id: Int) -> CellStatus {
        if selectedId.contains(id) {
            return .selected
        } else if toDistroyId.contains(id) {
            return .distroyed
        } else if toCreateID.contains(id) {
            return .created
        } else {
            return .none
        }
    }
    
    func onDistoryFinished(_ id: Int) {
        self.toDistroyId = toDistroyId.filter { $0 != id }
        colors[id] = .init(id: id, color: allColors.randomElement()!)
        self.toCreateID.append(id)
    }
    
    func onCreateFinished(_ id: Int) {
        self.toCreateID = toCreateID.filter { $0 != id }
    }
}

enum CellStatus {
    case none, selected, created, distroyed
}

struct PuzzleCellEntry: Identifiable {
    let id: Int
    let color: Color
}

private struct PuzzleCell: View {
    
    let entry: PuzzleCellEntry
    let status: CellStatus
    let onDistoryFinished: () -> Void
    let onCreatedFinished: () -> Void
    
    @State var scale: CGFloat = 1.0
    
    var body: some View {
        entry.color
            .opacity(status == .selected ? 1 : 0.5)
            .frame(width: 30, height: 30)
            .overlay(
                Text("\(entry.id)")
            )
            .scaleEffect(scale)
            .onAppear {
                if status == .distroyed {
                    withAnimation {
                        scale = 0
                    } completion: {
                        onDistoryFinished()
                    }
                } else if status == .created {
                    self.scale = 0
                    withAnimation {
                        scale = 1
                    } completion: {
                        onCreatedFinished()
                    }
                }
            }
    }
    
}

#Preview {
    PuzzleBoard()
}
