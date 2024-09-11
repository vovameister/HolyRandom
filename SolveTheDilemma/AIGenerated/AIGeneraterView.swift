//
//  AIGeneraterView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//

import SwiftUI

struct AIGeneratorView: View {
    @StateObject var viewModel: AIGeneraterViewModel
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard() 
                }
            VStack {
                MultilineTextField(text: $viewModel.requestText)
                    .padding()
                
                Button(action: {
                    viewModel.doRequest()
                    print("Entered text: \(viewModel.requestText)")
                }) {
                    Text("Submit")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .overlay(
                   viewModel.showBanner ? BannerView(items: viewModel.historyItems, onClose: {
                       viewModel.showBanner = false
                   }, onOK: {
                       print("OK нажата")
                       
                   })
                   .transition(.move(edge: .top).combined(with: .opacity))
                   .animation(.spring(), value: viewModel.showBanner)
                   : nil
               )
    }
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#Preview {
    AIGeneratorView(viewModel: AIGeneraterViewModel())
}
