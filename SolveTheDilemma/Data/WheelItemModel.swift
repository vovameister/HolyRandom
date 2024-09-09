//
//  Item.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 3.9.24..
//

import Foundation

struct WheelItem: Identifiable {
    var id: UUID
    var text: String?
    
    init(text: String, id: UUID) {
        self.text = text
        self.id = id
    }
}
