//
//  ContentView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//

import SwiftUI

struct WheelMainView: View {
    @ObservedObject var viewModel: WheelViewModel
    @State private var isPresentedChange = false
    @State private var isPresentedCreate = false
    @State private var spinTriggered = true
    @State private var resetTrigger = false
    @State private var showLabelResult = false
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            Image("backMain")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .frame(minWidth: 0)
            VStack {
                Spacer().frame(minHeight: 40, maxHeight: 80)
                    .layoutPriority(2)
                HStack {
                    EditButtonView(action: {
                        isPresentedChange.toggle()
                    }, iconName: "square.and.pencil.circle.fill")
                    
                    Spacer()
                    
                    DownArrowView()
                        .offset(y: 15)
                    
                    Spacer()
                    
                    EditButtonView(action: {
                        isPresentedCreate.toggle()
                    }, iconName: "plus.circle")
                }
                .padding(.leading, 40)
                .padding(.trailing, 40)
                let wheel = WheelOfFortune(viewModel: viewModel, spinTriggered: $spinTriggered)
                if resetTrigger {
                    wheel
                } else {
                    wheel
                }
                
                Spacer().layoutPriority(2)
                Button(action: {
                    viewModel.spinWheel()
                    spinTriggered.toggle()
                }) {
                    //Image(systemName: "arrow.uturn.down.circle.fill")
                    Image(systemName: "hare")
                    //Image(systemName: "digitalcrown.arrow.clockwise.fill")
                        .resizable()
                        //.scaleEffect(x: -1, y: 1)
                        .frame(width: 50, height: 50)
                        .padding()
                        .background(!viewModel.isSpinning ? Color.wheelYellow : Color.gray)
                        .foregroundColor(.wheelBlue)
                        .cornerRadius(50)
                }
                .disabled(viewModel.isSpinning)
                Spacer().layoutPriority(2)
                SelectTimeView(viewModel: viewModel)
                Spacer().layoutPriority(2)
            }
            .padding(.bottom, 10)
            .fullScreenCover(isPresented: $isPresentedCreate) {
                CreateWheelView(wheelViewModel: viewModel)
            }
            .fullScreenCover(isPresented: $isPresentedChange) {
                CreateWheelView(items: viewModel.wheelItem, wheelViewModel: viewModel)
            }
            if showLabelResult {
                BlurView()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.6)
                    .transition(.opacity)
                
                Text(viewModel.selectedWordShow)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .foregroundColor(.black)
                    .transition(.move(edge: .top).combined(with: .scale).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.6), value: showLabelResult)
        .onChange(of: viewModel.wheelItem) { _ in
            resetTrigger.toggle()
        }
        .onChange(of: viewModel.isSpinning) { _ in
            if !viewModel.isSpinning {
                showLabelResult.toggle()
            }
        }
        .onTapGesture {
            showLabelResult = false
        }
    }
}

#Preview {
    WheelMainView(viewModel: WheelViewModel(coreDataManager: CoreDataManager()))
}

