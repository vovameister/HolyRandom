//
//  AIGeneraterView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//

import SwiftUI

struct AIGeneratorView: View {
    @State private var text: String = ""
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
                .onTapGesture {
                                    hideKeyboard() 
                                }
                    VStack {
                        MultilineTextField(text: $text)
                            .padding()

                        Button(action: {
                            print("Entered text: \(text)")
                        }) {
                            Text("Submit")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                }
        .onAppear() {
            Task {
                do {
                    let history = try await ChatGptRequest.shared.sendRequest()
                    print("История успешно получена: \(history)")
                } catch {
                    print("Произошла ошибка: \(error)")
                }
            }
        }
        }
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}
#Preview {
    AIGeneratorView()
}
