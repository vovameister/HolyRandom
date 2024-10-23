//
//  SelectTimeView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 13.9.24..
//

import SwiftUI

struct SelectTimeView: View {
    @ObservedObject var viewModel: WheelViewModel
    @State private var selectedTab: Int = 0
    
    var body: some View {
        HStack(spacing: 0) {
            TimeButton2(image: "figure.roll.runningpace", isSelected: selectedTab == 0) {
                selectedTab = 0
                viewModel.duration = 1
            }
            .clipShape(CustomRoundedCorners(corners: [.topLeft, .bottomLeft], radius: 10))
            
            TimeButton2(image: "wheelchair", isSelected: selectedTab == 1) {
                selectedTab = 1
                viewModel.duration = 3
            }
            
            TimeButton2(image: "hare", isSelected: selectedTab == 2)  {
                selectedTab = 2
                viewModel.duration = 5
            }
            
            TimeButton2(image: "tortoise", isSelected: selectedTab == 3) {
                selectedTab = 3
                viewModel.duration = 10
            }
            .clipShape(CustomRoundedCorners(corners: [.topRight, .bottomRight], radius: 10))
        }
        .padding()
        .frame(width: 285, height: 50)
    }
}
    #Preview {
        SelectTimeView(viewModel: WheelViewModel(coreDataManager: CoreDataManager()))
    }