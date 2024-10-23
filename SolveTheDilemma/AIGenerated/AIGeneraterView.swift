//
//  AIGeneraterView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//

import SwiftUI

struct AIGeneratorView: View {
    @ObservedObject var viewModel: AIGeneraterViewModel
    @ObservedObject var wheelViewModel: WheelViewModel
    @Binding var selectedTab: Int
    @State var isPresentedChange = false
    
    var body: some View {
        ZStack {
            Color.wheelGray
                .ignoresSafeArea()
                .onTapGesture {
                    hideKeyboard() 
                }
            VStack {
                HStack {
                    QuestionMarkButton(action: {
                        isPresentedChange.toggle()
                    })
                        .padding(.leading, 20)
                    Spacer()
                }
                MultilineTextField(text: $viewModel.requestText)
                    .cornerRadius(8)
                    .padding()
                    .padding(.top, 20)
                
                Button(action: {
                    viewModel.doRequest()
                    print("Entered text: \(viewModel.requestText)")
                }) {
                    Text("Submit")
                        .padding()
                        .background(Color.wheelPink)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Spacer()
            }
            .padding()
        }
        .fullScreenCover(isPresented: $isPresentedChange) {
            PostSctiptumView(isPresented: $isPresentedChange)
        }
        .overlay(
                   viewModel.showBanner ? BannerView(items: viewModel.aigeneratedItems, onClose: {
                       viewModel.showBanner = false
                   }, onOK: {
                       wheelViewModel.saveWords(with: viewModel.aigeneratedItems)
                       selectedTab = 0
                   })
                   .transition(.move(edge: .top).combined(with: .opacity))
                   .animation(.spring(), value: viewModel.showBanner)
                   : nil
               )
    }
}
#Preview {
    AIGeneratorView(viewModel: AIGeneraterViewModel(), wheelViewModel: WheelViewModel(coreDataManager: CoreDataManager()), selectedTab: .constant(2))
}
