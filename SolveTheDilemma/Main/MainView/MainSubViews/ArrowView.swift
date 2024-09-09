//
//  ArrowView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//
import SwiftUI

struct DownArrowView: View {
    var body: some View {
        Text("↓")
            .font(.largeTitle)
            .foregroundColor(.red)
            .rotationEffect(.degrees(0))
    }
}

struct DownArrowView_Previews: PreviewProvider {
    static var previews: some View {
        DownArrowView()
    }
}
