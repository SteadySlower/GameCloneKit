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
    
    @State private var cancellable: AnyCancellable?
    @State private var isReverse: Bool = false

    var body: some View {
        ZStack {
            // 반원 경로 그리기
            HalfCirclePath()
                .stroke(Color.gray, lineWidth: 2)
                .frame(width: 200, height: 100) // 반원 크기 설정

            // 반원 경로를 따라 움직이는 Circle
            Circle()
                .fill(Color.blue)
                .frame(width: 20, height: 20)
                .offset(
                    x: 100 * cos(Angle.degrees(degree).radians),
                    y: -100 * sin(Angle.degrees(degree).radians)
                )
        }
        .onAppear { startAnimation() }
    }
    
    private func startAnimation() {
        let timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
        self.cancellable = timer.sink { _ in
            degree += isReverse ? -1 : 1
            if degree == 180 || degree == 0 {
                isReverse.toggle()
            }
        }
    }
}

struct HalfCirclePath: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        // 반원 경로 설정 (시작 각도: 180도, 종료 각도: 0도)
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width / 2,
                    startAngle: .degrees(180),
                    endAngle: .degrees(0),
                    clockwise: false)
        return path
    }
}

#Preview {
    HalfCircleAnimationView()
}
