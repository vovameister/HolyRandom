//
//  HistoryView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: HistoryViewModel
    @ObservedObject var wheelViewModel: WheelViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            GradientBackgroundView()
                .onTapGesture {
                    hideKeyboard()
                }
            VStack {
                SearchBar(searchText: $viewModel.searchText)
                    .padding(.top, 30)
                Spacer()
            if viewModel.historyGroups.isEmpty {
                Text("No saved data yet.")
                    .font(.headline)
                    .foregroundColor(.white)
                Spacer()
            } else {
                    List {
                        ForEach(viewModel.filteredHistoryGroups, id: \.date) { group in
                            Section(header: HStack {
                                Text("\(group.date, formatter: dateFormatter)")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        hideKeyboard()
                                    }
                                Spacer()
                                Button(action: {
                                    viewModel.deleteGroup(group)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.wheelTrash)
                                        .padding(.bottom, 12)
                                }
                            }) {
                                ForEach(group.item.indices, id: \.self) { index in
                                    let item = group.item[index]
                                    //                                let isLastItem = index == group.item.count - 1
                                    let cellContent = VStack(spacing: 0) {
                                        Text(item.text ?? "No Name")
                                            .padding(.vertical, 8)
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                        //                                    if !isLastItem {
                                        //                                        Divider()
                                        //                                            .frame(height: 1)
                                        //                                            .background(Color.gray)
                                        //                                    }
                                    }
                                    
                                    Button(action: {
                                        wheelViewModel.updateWords(with: group.item)
                                        selectedTab = 0
                                    }) {
                                        cellContent
                                    }
                                    .listRowBackground(Color.white)
                                    .listRowSeparator(.hidden)
                                }
                            }
                        }
                    }
                    .animation(.easeOut, value: viewModel.filteredHistoryGroups)
                    .scrollContentBackground(.hidden)
                    .background(Color.clear)
                    .listStyle(InsetGroupedListStyle())
                }
            }
        }
        .onDisappear() {
            print("onDisappear")
        }
    }
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
}

#Preview {
    HistoryView(viewModel: HistoryViewModel(coreDataManager: CoreDataManager()), wheelViewModel: WheelViewModel(coreDataManager: CoreDataManager()), selectedTab: .constant(1))
}
