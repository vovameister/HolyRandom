//
//  PostScriptumView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 1.10.24..
//

import SwiftUI

struct PostSctiptumView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack {
                HStack {
                    Spacer()
                    CrossButtonView(action: {
                        isPresented.toggle()
                    })
                }
                Text("""
                To generate options, provide a request with a topic and the number of options (up to 20). ChatGPT is used for generating responses. Inaccurate phrasing may lead to unpredictable results.
                """)
                .font(.body)
                .multilineTextAlignment(.leading)
                .foregroundColor(.black)
                .padding()
                
                Spacer()
            }
            .padding(.horizontal, 30)
        }
    }
}

#Preview {
    PostSctiptumView(isPresented: .constant(true))
}
