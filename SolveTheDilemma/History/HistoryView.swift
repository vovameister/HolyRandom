//
//  HistoryView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    
    var body: some View {
        ZStack {
            Color.pink
                .ignoresSafeArea()
            
            if viewModel.historyGroups.isEmpty {
                Text("No saved data yet.")
                    .font(.headline)
                    .foregroundColor(.white)
            } else {
                List {
                    ForEach(viewModel.historyGroups, id: \.date) { group in
                        Section(header: HStack {
                            Text("Date: \(group.date.formatted())")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Button(action: {
                                viewModel.deleteGroup(group)
                            })  {
                                Image(systemName: "trash")
                                    .foregroundColor(.blue)
                            }
                        }) {
                            ForEach(group.item, id: \.id) { item in
                                Text(item.text ?? "No Name")
                                    .padding(.vertical, 8)
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color.pink)
                .listStyle(InsetGroupedListStyle())
            }
        }
        .onAppear {
            viewModel.fetchGroups()
        }
    }
}
#Preview {
    HistoryView(viewModel: HistoryViewModel())
}
