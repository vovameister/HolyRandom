//
//  CornerRadius.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 13.9.24..
//
import SwiftUI

struct CustomRoundedCorners: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
