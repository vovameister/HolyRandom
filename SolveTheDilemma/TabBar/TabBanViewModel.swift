//
//  TabBanViewModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 11.9.24..
//

import Foundation

class MainTabViewModel: ObservableObject {
    let coreDataManager: CoreDataManager

    init() {
        self.coreDataManager = CoreDataManager()
    }
}
