//
//  TabBarView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//
import SwiftUI

struct MainTabView: View {
    private let wheelViewModel: WheelViewModel
    private let historyViewModel: HistoryViewModel


    init() {
        self.wheelViewModel = WheelViewModel()
        self.historyViewModel = HistoryViewModel()

        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemTeal

        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]

        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.gray]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

    var body: some View {
        TabView {
            WheelMainView(viewModel: wheelViewModel)
                .tabItem {
                    Image(systemName: "circle.grid.cross")
                    Text("Wheel")
                }

            HistoryView(viewModel: historyViewModel)
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("History")
                }

            AIGeneratorView()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("AI Generator")
                }
        }
    }
}

#Preview {
    MainTabView()
}
