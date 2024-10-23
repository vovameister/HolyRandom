//
//  AIGeneraterViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 11.9.24..
//

import Foundation

final class AIGeneraterViewModel: ObservableObject {
    @Published var requestText: String = ""
    @Published var aigeneratedItems: [WheelItem] = []
    @Published var showBanner: Bool = false
    var networkService: ChatGptRequestProtocol = ChatGptRequestService()
    
    func doRequest() {
        guard !requestText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("Ошибка: Введён пустой текст запроса")
            return
        }
        Task {
            do {
                let aigenerated = try await networkService.sendRequest(text: requestText)
                await MainActor.run {
                    self.aigeneratedItems = aigenerated.item
                    self.showBanner = true
                }
                print("История успешно получена: \(aigenerated)")
            } catch {
                print("Произошла ошибка: \(error)")
            }
        }
    }
    deinit {
        print("ai deinited")
    }
}
