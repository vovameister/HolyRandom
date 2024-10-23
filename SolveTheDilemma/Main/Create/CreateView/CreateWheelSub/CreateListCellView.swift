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
        TextField("Введите текст", text: Binding($item.text, replacingNilWith: ""))
            .font(.system(size: 18, weight: .regular))
            .foregroundColor(.black)
            //.textFieldStyle(
    }
}

#Preview {
    CreateListCellView(item: .constant(WheelItem(text: "Пример", id: UUID())))
}

