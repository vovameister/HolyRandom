//
//  AIGeneraterViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 11.9.24..
//

import Foundation

final class AIGeneraterViewModel: ObservableObject {
    @Published var requestText: String = ""
    @Published var historyItems: [WheelItem] = []
    @Published var showBanner: Bool = false
    var networkService: ChatGptRequestProtocol = ChatGptRequestService()
    
    func doRequest() {
        guard !requestText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Ошибка: Введён пустой текст запроса")
            return
        }
        Task {
            do {
                let history = try await networkService.sendRequest(text: requestText)
                await MainActor.run {
                    self.historyItems = history.item
                    self.showBanner = true
                }
                
                
                print("История успешно получена: \(history)")
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
}
