//
//  SavedView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/14/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SavedView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var cuisines: [FoodItemData]

    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Button("Delete All") {
                    Task {
                        deleteAll()
                    }
                }
                .padding()
                .overlay(
                    Capsule()
                        .stroke(.gray, lineWidth: 1)
                )
                .padding([.leading, .trailing], 20)
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(cuisines) { food in
                        NavigationLink {
                            SavedCuisineDetail(foodItem: food)
                        } label: {
                            SavedCuisineItem(foodItem: food)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                }
                .padding(.horizontal)
            } 
            .navigationTitle("Saved")
        }
    }
    
    func deleteAll() {
        do {
            try modelContext.delete(model: FoodItemData.self)
        } catch {
            print("Failed to clear all Food Data.")
        }
    }
}
