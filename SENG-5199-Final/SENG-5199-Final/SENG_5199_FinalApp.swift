//
//  SENG_5199_FinalApp.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import SwiftUI
import SwiftData

@main
struct SENG_5199_FinalApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            FoodItemData.self,
            RecentSearchModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: modelConfiguration)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
