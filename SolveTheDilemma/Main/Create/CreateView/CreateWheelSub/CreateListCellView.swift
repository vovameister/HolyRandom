//
//  CreateList.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 4.9.24..
//
import SwiftUI

struct CreateListCellView: View {
    @Binding var item: WheelItem
    
    var body: some View {
        HStack {
            TextField("Введите текст", text: Binding($item.text, replacingNilWith: ""))
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

#Preview {
    CreateListCellView(item: .constant(WheelItem(text: "Пример", id: UUID())))
}

