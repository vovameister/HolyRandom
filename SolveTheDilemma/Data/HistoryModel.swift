//
//  HistoryModel.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 9.9.24..
//

import Foundation

struct HistoryModel: Identifiable, Equatable {
    var id = UUID()
    var date: Date
    var item: [WheelItem]
}
