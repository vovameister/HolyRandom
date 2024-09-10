//
//  CreateWheelViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 4.9.24..
//
import Combine
import Foundation

final class CreateWheelViewModel: ObservableObject {
    @Published var items: [WheelItem] = [
        WheelItem(text: "Первый элемент", id: UUID()),
        WheelItem(text: "Второй элемент", id: UUID()),
        WheelItem(text: "Третий элемент", id: UUID())
    ]

    func updateItemText(for item: WheelItem, with newText: String) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].text = newText
        }
    }
    
    func addItem() {
        items.append(WheelItem(text: "", id: UUID()))
    }
    
    func removeLastItem() {
        if !items.isEmpty {
            items.removeLast()
        }
    }
}
