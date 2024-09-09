//
//  СrossButton.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 4.9.24..
//

import SwiftUI

struct CrossButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "xmark")
            .resizable()
            .frame(width: 15, height: 15)
            .padding()
            .foregroundColor(.black)
            .cornerRadius(10)
        }
    }
    
}
#Preview {
    CrossButtonView(action: {
        
    })
}
