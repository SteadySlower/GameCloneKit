//
//  SwiftUIView.swift
//  
//
//  Created by JW Moon on 8/26/24.
//

import SwiftUI
import Combine

struct HalfCircleAnimationView: View {
    
    @State var degree: Double = 0

    @State private var isReverse: Bool = false
    
    private let ballSize: CGFloat = 20

    var body: some View {
        GeometryReader { proxy in
            let height = proxy.size.height
            let width = height
            VStack {
                ZStack(alignment: .topLeading) {
                    HStack(spacing: 0) {
                        QuarterCirclePath(isLeft: true)
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: width, height: height)
                        HalfCirclePath()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: width * 2, height: height)
                        QuarterCirclePath(isLeft: false)
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: width, height: height)
                    }


                    // 반원 경로를 따라 움직이는 Circle
                    Circle()
                        .fill(Color.blue)
                        .frame(width: ballSize, height: ballSize)
                        .offset(
                            x: -ballSize / 2,
                            y: -ballSize / 2
                        )
                }
                Button("반대로") {
                    isReverse.toggle()
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
}

struct HalfCirclePath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(
                x: rect.midX,
                y: rect.maxY
            ),
            radius: rect.width / 2,
            startAngle: .degrees(180),
            endAngle: .degrees(0),
            clockwise: false
        )
        return path
    }
}

struct QuarterCirclePath: Shape {
    
    let startAngle: CGFloat
    let endAngle: CGFloat
    let isLeft: Bool
    
    init(isLeft: Bool) {
        self.isLeft = isLeft
        self.startAngle = isLeft ? -90 : -180
        self.endAngle = isLeft ? 0 : -90
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.addArc(
            center: CGPoint(
                x: isLeft ? rect.minX : rect.maxX,
                y: rect.maxY
            ),
            radius: rect.width,
            startAngle: .degrees(startAngle),
            endAngle: .degrees(endAngle),
            clockwise: false
        )
        return path
    }
}

#Preview {
    HalfCircleAnimationView()
        .frame(height: 50)
}
