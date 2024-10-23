//
//  TimeButton.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 13.9.24..
//

import Foundation

import SwiftUI

struct TimeButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Text(title)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.gray)
                .foregroundColor(.white)
                .font(.system(size: 10))
        }
    }
}
