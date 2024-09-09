//
//  TabBarView.swift
//  SolveTheDilemma
//
//  Created by Владимир Клевцов on 5.9.24..
//
import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: Int = 0 
    @StateObject private var wheelViewModel = WheelViewModel()
    @StateObject private var historyViewModel = HistoryViewModel()

    init() {
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
        TabView(selection: $selectedTab) {
            WheelMainView(viewModel: wheelViewModel)
                .tabItem {
                    Image(systemName: "circle.grid.cross")
                    Text("Wheel")
                }
                .tag(0)

            HistoryView(viewModel: historyViewModel, wheelViewModel: wheelViewModel, selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("History")
                }
                .tag(1)

            AIGeneratorView()
                .tabItem {
                    Image(systemName: "brain.head.profile")
                    Text("AI Generator")
                }
                .tag(2)
        }
    }
}

#Preview {
    MainTabView()
}
