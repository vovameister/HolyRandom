//
//  ChatGptRequest.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 10.9.24..
//

import Foundation

protocol ChatGptRequestProtocol: AnyObject {
    func sendRequest(text: String) async throws -> HistoryModel
}

final class ChatGptRequestService: ChatGptRequestProtocol {

    func sendRequest(text: String) async throws -> HistoryModel {
        guard let url = URL(string: "https://35d1-87-116-162-101.ngrok-free.app/api/chat") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(ChatRequest(message: text))

        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
        
        return HistoryModel(
            date: Date(),
            item: chatResponse.reply.map { WheelItem(text: $0, id: UUID()) }
        )
    }
}

struct ChatRequest: Codable {
    let message: String
}

struct ChatResponse: Codable {
    let reply: [String]
}
