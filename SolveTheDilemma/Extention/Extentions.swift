//
//  Extentions.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 9.9.24..
//
import SwiftUI

extension Binding {
    init(_ source: Binding<Value?>, replacingNilWith nilReplacement: Value) {
        self.init(
            get: { source.wrappedValue ?? nilReplacement },
            set: { source.wrappedValue = $0 }
        )
    }
}
