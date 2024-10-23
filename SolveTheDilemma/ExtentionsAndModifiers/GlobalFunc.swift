//
//  GlobalFunc.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 11.10.24..
//
import SwiftUI

func hideKeyboard() {
   UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}
