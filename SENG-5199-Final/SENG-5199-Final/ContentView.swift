//
//  ContentView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    @State private var selection: Tab = .explore
    enum Tab {
        case explore
        case search
        case saved
    }
    
    var body: some View {
        TabView(selection: $selection) {
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
        .preferredColorScheme(.dark)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
