//
//  ContentView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import SwiftUI
import SwiftData

enum Tab {
    case explore
    case search
    case saved
}

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject var filter = ViewModel.shared
    @State var currentTab: Tab = Tab.explore

    var body: some View {
        TabView(selection: $filter.tabSelection) {
            CusineView()
                .tabItem {
                    Label("Explore", systemImage: "fork.knife.circle")
                }
                .tag(Tab.explore)
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle")
                }
                .tag(Tab.search)
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "checklist.checked.rtl")
                }
                .tag(Tab.saved)
        }
        .onReceive(filter.$tabSelection) { selection in
            if (selection == currentTab) {
                filter.navToHome.toggle()
            } else {
                currentTab = selection
            }
        }
        .preferredColorScheme(.dark)
    }

}
