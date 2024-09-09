//
//  TextView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 6.9.24..
//
import SwiftUI

struct MultilineTextField: View {
    @Binding var text: String
    
    let maxLines: Int = 6
    let lineHeight: CGFloat = 20.0

    var body: some View {
        TextEditor(text: $text)
            .frame(height: lineHeight * CGFloat(maxLines))
            .padding(4)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .onChange(of: text) { newText in
                // Ограничиваем количество строк до 6
                let lines = newText.split(whereSeparator: \.isNewline)
                if lines.count > maxLines {
                    self.text = lines.prefix(maxLines).joined(separator: "\n")
                }
            }
    }
}
#Preview {
    @State var previewText = ""
    return MultilineTextField(text: $previewText)
}
