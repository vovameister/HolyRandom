//
//  ChatGptRequest.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 10.9.24..
//

import Foundation

protocol ChatGptRequestProtocol {
    func sendRequest(text: String) async throws -> HistoryModel
}

final class ChatGptRequestService: ChatGptRequestProtocol {

    func sendRequest(text: String) async throws -> HistoryModel {
        guard let url = URL(string: "https://0b52-24-135-205-92.ngrok-free.app/api/chat") else {
            throw URLError(.badURL)
        }
   
        let requestObject = ChatRequest(message: text)
  
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(requestObject)
            request.httpBody = jsonData
        } catch {
            print("Ошибка преобразования данных: \(error)")
            throw error
        }

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
            
            let items = chatResponse.reply.map { WheelItem(text: $0, id: UUID()) }
            
            let history = HistoryModel(date: Date(), item: items)
            
            return history
        } catch {
            print("Ошибка при декодировании ответа: \(error)")
            throw error
        }
    }
}

struct ChatRequest: Codable {
    let message: String
}

struct ChatResponse: Codable {
    let reply: [String]
}
