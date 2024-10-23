//
//  CreateWheelViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 4.9.24..
//
import Foundation

final class CreateWheelViewModel: ObservableObject {
    @Published var items: [WheelItem]
    
    init() {
        self.items = [
            WheelItem(text: "", id: UUID()),
            WheelItem(text: "", id: UUID())
        ]
    }
    
    init(items: [WheelItem]) {
        self.items = items
    }
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
    deinit {
        print("create deinited")
    }
}
