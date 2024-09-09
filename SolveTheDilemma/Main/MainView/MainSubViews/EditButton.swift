//
//  EditButton.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//
import SwiftUI

struct EditButtonView: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: "pencil")
            .resizable()
            .frame(width: 15, height: 15)
            .padding()
            .background(Color.gray)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }
    
}
#Preview {
    EditButtonView(action: {
        print("Edit button tapped")
    })
}
