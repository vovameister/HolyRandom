//
//  WheelView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//

import SwiftUI

struct WheelOfFortune: View {
    @ObservedObject var viewModel: WheelViewModel
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue)
                .frame(width: 300, height: 300)
            
            ForEach(0..<viewModel.words.count, id: \.self) { index in
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 2, height: 150)
                    .offset(y: -75)
                    .rotationEffect(self.anglelines(for: index))
            }
            
            ForEach(0..<viewModel.words.count, id: \.self) { index in
                VStack {
                    Spacer()
                    Text(viewModel.words[index])
                    // .rotationEffect(.degrees(90))
                        .padding(.bottom, 15)
                }
                .frame(width: 300, height: 300)
                .rotationEffect(self.angle(for: index))
            }
        }
        .rotationEffect(.degrees(180) , anchor: .center)
        .rotationEffect(.degrees(rotationAngle()), anchor: .center)
        .animation(.easeOut(duration: TimeInterval(viewModel.duration)), value: viewModel.selectedWord)
    }
    
    private func angle(for index: Int) -> Angle {
        return .degrees(Double(index) * (360.0 / Double(viewModel.words.count)))
    }
    private func anglelines(for index: Int) -> Angle {
        let baseAngle = Double(index) * (360.0 / Double(viewModel.words.count))
          
            if viewModel.words.count % 2 == 0 {
                let halfAngleOffset = (360.0 / Double(viewModel.words.count)) / 2
                return .degrees(baseAngle + halfAngleOffset)
            } else {
                return .degrees(baseAngle)
            }
    }
    private func rotationAngle() -> Double {
        guard let selectedIndex = viewModel.words.firstIndex(of: viewModel.selectedWord) else {
            return 0.0
        }
        
        let minimumSpinsAngle = 180.0 * Double(viewModel.duration)
        let wordAngle = Double(selectedIndex) * (360.0 / Double(viewModel.words.count)) + minimumSpinsAngle
        return -wordAngle
    }
}
#Preview {
    WheelOfFortune(viewModel: WheelViewModel())
}
