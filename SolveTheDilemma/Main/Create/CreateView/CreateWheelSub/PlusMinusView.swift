//
//  PlusMinusView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 4.9.24..
//

import SwiftUI

struct PlusMinusButtonsView: View {
    @ObservedObject var viewModel: CreateWheelViewModel
    
    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
                viewModel.removeLastItem()
            }) {
                Image(systemName: "minus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.red)
            }
            .padding(.leading, 40)
            Spacer()
            
            Button(action: {
                viewModel.addItem()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.yellow)
            }
            .padding(.trailing, 40)
        }
    }
}

#Preview {
    PlusMinusButtonsView(viewModel: CreateWheelViewModel())
}
