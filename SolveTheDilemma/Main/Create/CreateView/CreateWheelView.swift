//
//  EditView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//

import SwiftUI

struct CreateWheelView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject private var createWheelViewModel = CreateWheelViewModel()
    @ObservedObject var wheelViewModel: WheelViewModel
    
    let cellHeight: CGFloat = 20.0
    let rowSpacing: CGFloat = 25.0
    
    var body: some View {
        ZStack {
            Color.mint
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    CrossButtonView(action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                        .padding(.trailing, 20)
                }
                
                List {
                    ForEach($createWheelViewModel.items) { $item in
                        CreateListCellView(item: $item)
                            .frame(height: 20)
                    }
                }
                .frame(maxHeight: CGFloat(createWheelViewModel.items.count) * (cellHeight + rowSpacing))
                .animation(.easeInOut, value: createWheelViewModel.items.count)
                .listStyle(PlainListStyle())
                
                PlusMinusButtonsView(viewModel: createWheelViewModel)
                    .animation(.easeInOut, value: createWheelViewModel.items.count)
                
                Spacer()
                
                Button(action: {
                    wheelViewModel.saveWords(with: createWheelViewModel.items)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Сохранить")
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
}
#Preview {
    CreateWheelView(wheelViewModel: WheelViewModel(coreDataManager: CoreDataManager()))
}
