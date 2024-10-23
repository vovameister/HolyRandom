//
//  BgGradient.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 11.10.24..
//

import SwiftUI

struct GradientBackgroundView: View {
    var body: some View {
//        LinearGradient(
//            gradient: Gradient(colors: [
//                .wheelBlue,  // Переход к более светлому синему
//                Color(red: 0.14, green: 0.2, blue: 0.45).opacity(0.9),   // Еще светлее, синий-фиолетовый
//                .wheelGray,   // Переход к фону с плавным градиентом
//                Color(red: 0.12, green: 0.16, blue: 0.35).opacity(0.9),  // Переход к более светлому
//                .wheelBlue    // Обратно к тёмно-синему
//            ]),
//            startPoint: .top,
//            endPoint: .bottom
        Color.wheelGray
        .ignoresSafeArea()
        .overlay(
            RadialGradient(
                gradient: Gradient(colors: [
                    .wheelBlue.opacity(0.4), // Оранжевый акцент
                    Color.clear
                ]),
                center: .bottom,
                startRadius: 50,
                endRadius: 400
            )
            .blendMode(.overlay)
        )
    }
}

struct GradientBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        GradientBackgroundView()
    }
}

