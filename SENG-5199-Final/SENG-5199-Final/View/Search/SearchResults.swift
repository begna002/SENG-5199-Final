//
//  SearchResults.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/14/24.
//

import Foundation
import SwiftUI

struct SearchResults: View {
    @State var cuisines: [FoodItem] = []
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(cuisines) { food in
                    NavigationLink {
                        CusineDetail(foodItem: food)
                    } label: {
                        CuisineItem(foodItem: food, width: 140, height: 140)
                    }
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .padding(.horizontal)
        }
    }
}
