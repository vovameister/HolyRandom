//
//  CornerShadowModifier.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 16.10.24..
//


import SwiftUI

struct CornerShadowModifier: ViewModifier {
    var color: Color
    var radius: CGFloat
    var cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.clear, lineWidth: radius)
                    .shadow(color: color, radius: radius)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            )
    }
}

extension View {
    func cornerShadow(color: Color = .white.opacity(1), radius: CGFloat = 40, cornerRadius: CGFloat = 20) -> some View {
        self.modifier(CornerShadowModifier(color: color, radius: radius, cornerRadius: cornerRadius))
    }
}
