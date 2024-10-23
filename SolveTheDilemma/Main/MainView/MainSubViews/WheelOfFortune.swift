//
//  WheelView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//
import SwiftUI
import AVFoundation

struct WheelOfFortune: View {
    @ObservedObject var viewModel: WheelViewModel
    @State private var totalRotation: Double = 180
    @State private var shouldAnimate = true
    @State private var lastIndex = 0
    @State private var soundEffect: AVAudioPlayer?
    @State private var soundTask: Task<Void, Never>?
    @State private var animationStartTime: Date?
    @State private var remainingAngle: Double = 0
    
    @Binding var spinTriggered: Bool
    private let wheelSize: CGFloat = 350
    
    var body: some View {
        ZStack {
            if #available(iOS 17.0, *) {
                Circle()
                    .stroke(.wheelBlue, lineWidth: 20)
                    .stroke(.wheelBlue, lineWidth: 10)
                    .frame(width: wheelSize, height: wheelSize)
                    .shadow(color: .white.opacity(0.4), radius: 20)
                    
            } else {
                Circle()
                .stroke(.wheelBlue, lineWidth: 20)
                .frame(width: wheelSize, height: wheelSize)
                .shadow(color: .white.opacity(0.4), radius: 20)
            }
              
            
            ForEach(0..<viewModel.wheelItem.count, id: \.self) { index in
                self.pieSlice(for: index)
                    .fill(self.colorForSector(index))
                    .frame(width: wheelSize, height: wheelSize)
            }
            
            ForEach(0..<viewModel.wheelItem.count, id: \.self) { index in
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 2, height: wheelSize / 2)
                    .offset(y: -(wheelSize / 4))
                    .rotationEffect(self.anglelines(for: index))
            }
            ForEach(0..<viewModel.wheelItem.count, id: \.self) { index in
                VStack {
                    Spacer()
                    Text(shortenText(viewModel.wheelItem[index].text ?? ""))
                        .rotationEffect(.degrees(-90))
                        .offset(y: -30)
                        .padding(.bottom, 15)
                }
                .frame(width: wheelSize - 50, height: wheelSize - 50)
                .rotationEffect(self.angle(for: index))
            }
        }
        .rotationEffect(.degrees(totalRotation), anchor: .center)
        .animation(.easeOut(duration: TimeInterval(viewModel.duration)), value: totalRotation)
        .onChange(of: viewModel.isSpinning) { newValue in
            if newValue {
                startSpinAnimation()
            } else {
                stopSoundTask()
            }
        }
        .onDisappear {
            stopSoundTask()
        }
        .onChange(of: viewModel.wheelItem) { _ in
            resetRotationWithoutAnimation()
        }
    }
    
    private func startSpinAnimation() {
        animationStartTime = Date()
        spinWheelAnimation()
        startSoundTask()
    }
    
    
    
    private func angle(for index: Int) -> Angle {
        return .degrees(Double(index) * (360.0 / Double(viewModel.wheelItem.count)))
    }
    
    private func anglelines(for index: Int) -> Angle {
        let baseAngle = Double(index) * (360.0 / Double(viewModel.wheelItem.count))
        if viewModel.wheelItem.count % 2 == 0 {
            let halfAngleOffset = (360.0 / Double(viewModel.wheelItem.count)) / 2
            return .degrees(baseAngle + halfAngleOffset)
        } else {
            return .degrees(baseAngle)
        }
    }
    
    private func spinWheelAnimation() {
        guard let selectedIndex = viewModel.wheelItem.firstIndex(where: { $0.text == viewModel.selectedWord }) else {
            return
        }
        let cellAngle = 360.0 / Double(viewModel.wheelItem.count)
        let minimumSpinsAngle = 360.0 * Double(viewModel.duration)
        let wordAngle = Double(selectedIndex) * cellAngle
        let lastIndexAngle = Double(lastIndex) * cellAngle
        lastIndex = selectedIndex
        let spinAngle = minimumSpinsAngle - wordAngle + lastIndexAngle
        totalRotation += spinAngle
        remainingAngle = spinAngle
    }
    
    private func resetRotationWithoutAnimation() {
        totalRotation = 180
        lastIndex = 0
    }
    
    private func shortenText(_ text: String) -> String {
        if text.count > 18 {
            let index = text.index(text.startIndex, offsetBy: 15)
            return String(text[..<index]) + "..."
        } else {
            return text
        }
    }
}


//SoundsFunctions
extension WheelOfFortune {
    private func playSound() async {
        guard let url = Bundle.main.url(forResource: "tick", withExtension: "mp3") else {
            print("not found")
            return
        }
        do {
            soundEffect = try AVAudioPlayer(contentsOf: url)
            soundEffect?.play()
            //print("play")
        } catch {
            print("Couldn't load sound file.")
        }
    }
    private func startSoundTask() {
        soundTask?.cancel()
        soundTask = Task {
            while !Task.isCancelled {
                let duration = viewModel.duration
                let elapsed = Date().timeIntervalSince(animationStartTime ?? Date())
                let coefficientSlowing = elapsed >= Double(duration) - 3 ? 0.9 + Double(duration / 5) : 1
                print(elapsed)
                let remainingDuration: Double = (max(Double(duration) + elapsed * coefficientSlowing, 0))
                let interval = calculateInterval(for: TimeInterval(remainingDuration))
                
                if elapsed >= Double(duration) - 0.1 {
                    break
                }
                await playSound()
                try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
            }
        }
    }
    
    private func stopSoundTask() {
        soundTask?.cancel()
    }
    
    private func calculateInterval(for remainingDuration: TimeInterval) -> TimeInterval {
        let sectorsToPass = remainingAngle / (360.0 / Double(viewModel.wheelItem.count))
        
        let interval = remainingDuration / sectorsToPass
        
        return max(interval, 0.08)
    }
    private func pieSlice(for index: Int) -> Path {
        let sliceAngle = 360.0 / Double(viewModel.wheelItem.count)
        let halfAngleOffset = viewModel.wheelItem.count % 2 == 0 ? sliceAngle / 2 : 0.0
        let startAngle = Angle(degrees: sliceAngle * Double(index) - 90 + halfAngleOffset)
        let endAngle = Angle(degrees: sliceAngle * Double(index + 1) - 90 + halfAngleOffset)
        let radius = wheelSize / 2

        var path = Path()
        path.move(to: CGPoint(x: radius, y: radius))
        path.addArc(center: CGPoint(x: radius, y: radius),
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path.closeSubpath()
        
        return path
    }
    
    private func colorForSector(_ index: Int) -> Color {
        let colors: [Color] = [
            .turquoise,
            .wheelGray,
            .wheelOrange2,
            .wheelLightBlue,
            .wheelLightRed,
            .wheelOrange,
            .wheelPink,
            .wheelYellow
        ]
        
        return colors[index % colors.count]
    }
}

