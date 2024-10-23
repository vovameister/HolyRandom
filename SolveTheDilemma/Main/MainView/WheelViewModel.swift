//
//  WheelViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//
import Foundation

final class WheelViewModel: ObservableObject {
    @Published var wheelItem: [WheelItem] = [WheelItem(text: "", id: UUID())] {
        didSet {
            cancelCurrentTask()
        }
    }
    @Published var selectedWord: String?
    @Published var selectedWordShow: String = ""
    @Published var duration = 1 {
        didSet {
            print(duration)
        }
    }
    @Published var isSpinning = false
    
    private var currentTask: Task<Void, Never>?
    private let coreDataManager: CoreDataCreateProtocol
    
    init(coreDataManager: CoreDataCreateProtocol) {
        self.coreDataManager = coreDataManager
        selectedWord = wheelItem.first?.text
    }
    
    func updateWords(with items: [WheelItem]) {
        self.wheelItem = items
    }
    
    func saveWords(with items: [WheelItem]) {
        self.wheelItem = items
        coreDataManager.saveWheelItemList(items: items, creationDate: Date())
    }
    
    func spinWheel() {
        if let randomItem = wheelItem.randomElement() {
            isSpinning = true
            selectedWord = randomItem.text
            currentTask = Task {
                await showSelected()
            }
        }
    }
    
    func showSelected() async {
        do {
            try await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            await MainActor.run {
                selectedWordShow = selectedWord ?? ""
                isSpinning = false
            }
        } catch {
            print("Task was cancelled")
        }
    }
    
    private func cancelCurrentTask() {
        currentTask?.cancel()
        currentTask = nil
        isSpinning = false
    }
}
