//
//  WheelViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//
import Combine
import Foundation


final class WheelViewModel: ObservableObject {
    @Published var words: [String] = []
    @Published var selectedWord: String = ""
    @Published var duration = 4
    
    private let coreDataManager = CoreDataManager.shared
    
    func updateWords(with items: [WheelItem]) {
   
        self.words = items.map { $0.text ?? "" }
    }
   
    func saveWords(with items: [WheelItem]) {
   
        self.words = items.map { $0.text ?? "" }
        coreDataManager.saveWheelItemList(items: items, creationDate: Date())
    }
    func fetchGroups() {

    }

    func spinWheel() {
        if let randomWord = words.randomElement() {
            selectedWord = randomWord
        }
    }

}
