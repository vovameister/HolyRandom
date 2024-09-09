//
//  CreateList.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 4.9.24..
//
import SwiftUI

struct CreateListCellView: View {
    @Binding var item: WheelItem
    var viewModel: CreateWheelViewModel
    
    var body: some View {
        HStack {
            TextField("Введите текст", text: Binding($item.text, replacingNilWith: ""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onChange(of: item.text ?? "") { newValue in
                    viewModel.updateItemText(for: item, with: newValue)
                }
        }
    }
}

#Preview {
    CreateWheelView(wheelViewModel: WheelViewModel())
}

