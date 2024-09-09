//
//  ContentView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//

import SwiftUI

struct WheelMainView: View {

    @StateObject var viewModel: WheelViewModel
    @State private var isPresented = false
    
    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()
            VStack {
                ZStack {
                    EditButtonView(action: {
                        isPresented.toggle()
                    })
                    .offset(x: 150, y: 0)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                    .padding(.trailing, 20)
                    DownArrowView()
                        .offset(x: 0, y: 40)
                }
                WheelOfFortune(viewModel: viewModel)
                    .padding(.top, 20)
                Spacer()
                Button(action: {
                    viewModel.spinWheel()
                }) {
                    Text("Spin the Wheel")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Spacer()
                
                
                Text("Selected: \(viewModel.selectedWord)")
                    .font(.largeTitle)
                    .padding()
                
                
                Spacer()
            }
            .fullScreenCover(isPresented: $isPresented) {
                CreateWheelView(wheelViewModel: viewModel)
            }
        }
    }
}

#Preview {
    WheelMainView(viewModel: WheelViewModel())
}
