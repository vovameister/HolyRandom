//
//  HistoryViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//
import Combine
import Foundation

final class HistoryViewModel: ObservableObject {
    
    private let coreDataManager: CoreDataManagerHistoryProtocol
    
    init(coreDataManager: CoreDataManagerHistoryProtocol) {
        self.coreDataManager = coreDataManager
    }
    @Published var historyGroups: [HistoryModel] = []
    
    func fetchGroups() {
        historyGroups = coreDataManager.fetchHistoryModels()
    }

    func deleteGroup(_ group: HistoryModel) {
           if let index = historyGroups.firstIndex(where: { $0.id == group.id }) {
               historyGroups.remove(at: index)

               coreDataManager.deleteHistoryModel(group)
           }
       }
}
