//
//  TimeButton.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 13.9.24..
//

import Foundation

import SwiftUI

struct TimeButton2: View {
    var image: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: image)
                //.resizable()
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue : Color.gray)
                .foregroundColor(.white)
        }
    }
}
