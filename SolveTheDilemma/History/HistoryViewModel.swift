//
//  HistoryViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//
import Combine
import Foundation

class HistoryViewModel: ObservableObject {
    
    private let coreDataManager = CoreDataManager.shared
    @Published var historyGroups: [HistoryModel] = []
    
    func fetchGroups() {
        historyGroups = coreDataManager.fetchHistoryModels()
    }

    func deleteGroup(_ group: HistoryModel) {
           // Find the index of the group to delete
           if let index = historyGroups.firstIndex(where: { $0.id == group.id }) {
               historyGroups.remove(at: index)
               
               // Also delete the corresponding group from Core Data (if applicable)
               coreDataManager.deleteHistoryModel(group)
           }
       }
}
