//
//  EditButton.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//
import SwiftUI

struct EditButtonView: View {
    let action: () -> Void
    let iconName: String
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }) {
                Image(systemName: iconName)
                    .resizable()
                    .foregroundColor(.wheelYellow)
            }
            .frame(width: 40, height: 40)
            Circle()
                .stroke(.wheelBlue.opacity(0.7), lineWidth: 2)
                .frame(width: 40, height: 40)
                .shadow(color: .white.opacity(0.9), radius: 15, x: 0, y: 0)
        }
        
//        .cornerRadius(20)
//        .frame(width: 40, height: 40)
//        .shadow(color: .white.opacity(0.9), radius: 1, x: 0, y: 0)
    }
}
#Preview {
    ZStack {
        Color.black
        EditButtonView(action: {
            print("Edit button tapped")
        }, iconName: "plus.circle")
    }
}
