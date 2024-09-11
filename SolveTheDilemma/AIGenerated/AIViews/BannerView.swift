//
//  BannerView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 11.9.24..
//

import SwiftUI

struct BannerView: View {
    let items: [WheelItem]
    var onClose: () -> Void
    var onOK: () -> Void

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    onClose()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .font(.title)
                }
                .padding([.top, .trailing], 10)
            }

            Text("Полученные результаты:")
                .font(.headline)
                .padding([.top, .bottom], 5)

            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(items, id: \.id) { item in
                        Text(item.text ?? "")
                            .font(.body)
                            .padding(.bottom, 2)
                    }
                }
                .padding()
            }
            Button(action: {
                onOK()
            }) {
                Text("Использовать в колесе")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding(.horizontal)
            .padding(.bottom, 20)
        }
        .frame(width: 300, height: 400)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 10)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}
