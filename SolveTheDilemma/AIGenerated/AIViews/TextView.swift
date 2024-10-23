//
//  TextView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 6.9.24..
//
import SwiftUI

struct MultilineTextField: View {
    @Binding var text: String
    
    let placeholder = "Enter request here..."
    let maxLines: Int = 6
    let lineHeight: CGFloat = 20.0
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            TextEditor(text: $text)
                .padding(10)
                .frame(width: 350, height: 300)
                .background(Color.white)
                .scrollContentBackground(.hidden)
                .onChange(of: text) { newText in
                    let lines = newText.split(whereSeparator: \.isNewline)
                    if lines.count > maxLines {
                        self.text = lines.prefix(maxLines).joined(separator: "\n")
                    }
                }
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .padding(15)
            }
        }
    }
}

#Preview {
    MultilineTextField(text: .constant(""))
}
