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
    
    let cellHeight: CGFloat = 30.0
    let rowSpacing: CGFloat = 20.0
    
    init(items: [WheelItem]? = nil, wheelViewModel: WheelViewModel) {
        if let items = items {
            _createWheelViewModel = StateObject(wrappedValue: CreateWheelViewModel(items: items))
        } else {
            _createWheelViewModel = StateObject(wrappedValue: CreateWheelViewModel())
        }
        self.wheelViewModel = wheelViewModel
    }
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
                .onTapGesture {
                    hideKeyboard()
                }
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
                            .background(Color.white)
                            //.listRowBackground(Color.clear)
                            .listRowBackground(Color.white)
                    }
                    .listRowSeparator(.hidden)
                }
                .padding(.horizontal, 20)
                .onTapGesture {
                    hideKeyboard()
                }
                .animation(.easeInOut, value: createWheelViewModel.items.count)
                .listStyle(PlainListStyle())
                
                
                PlusMinusButtonsView(viewModel: createWheelViewModel)
                    .animation(.easeInOut, value: createWheelViewModel.items.count)
                Spacer(minLength: 30)
                
                Button(action: {
                    wheelViewModel.saveWords(with: createWheelViewModel.items)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Сохранить")
                        .padding()
                        .background(.wheelYellow)
                        .foregroundColor(.wheelBlue)
                        .cornerRadius(8)
                }
            }
        }
    }
}
#Preview {
    CreateWheelView(wheelViewModel: WheelViewModel(coreDataManager: CoreDataManager()))
}
