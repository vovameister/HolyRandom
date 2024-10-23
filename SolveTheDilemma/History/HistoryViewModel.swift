//
//  HistoryViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//
import Foundation
import Combine

final class HistoryViewModel: ObservableObject {
    
    private let coreDataManager: CoreDataManagerHistoryProtocol
    private var cancellables: Set<AnyCancellable> = []
    @Published var searchText: String = ""
    
    init(coreDataManager: CoreDataManagerHistoryProtocol) {
        self.coreDataManager = coreDataManager
        fetchGroups()
        
        coreDataManager.dataChangedSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] in
                self?.fetchGroups()
            }
            .store(in: &cancellables)
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] newValue in
                self?.applyFilter(newValue)
            }
            .store(in: &cancellables)
    }
    @Published var historyGroups: [HistoryModel] = []
    @Published var filteredHistoryGroups: [HistoryModel] = []
    
    func fetchGroups() {
        historyGroups = coreDataManager.fetchHistoryModels()
        filteredHistoryGroups = historyGroups
        applyFilter(searchText)
    }
    
    func deleteGroup(_ group: HistoryModel) {
        historyGroups.removeAll { $0.id == group.id }
        filteredHistoryGroups.removeAll { $0.id == group.id }
        
        coreDataManager.deleteHistoryModel(group)
    }
    func applyFilter(_ searchText: String) {
        if searchText.isEmpty {
            filteredHistoryGroups = historyGroups
        } else {
            filteredHistoryGroups = historyGroups.filter { group in
                let dateString = DateFormatter.localizedString(from: group.date, dateStyle: .short, timeStyle: .none)
                let dateMatches = dateString.contains(searchText)
                
                let itemsMatch = group.item.contains { item in
                    if let itemText = item.text?.lowercased() {
                        return itemText.contains(searchText.lowercased())
                    }
                    return false
                }
                
                return dateMatches || itemsMatch
            }
        }
    }
}
