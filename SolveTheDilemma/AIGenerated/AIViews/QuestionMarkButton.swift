//
//  questionMarkButton.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 1.10.24..
//

import SwiftUI

struct QuestionMarkButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "questionmark.circle")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    QuestionMarkButton(action: {
        
    })
}
