//
//  SearchResults.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/14/24.
//

import Foundation
import SwiftUI

struct SearchResults: View {
    var cuisines: [FoodItem] = []
    var size: CGFloat = 150
    var spacing: CGFloat = 20
    var isSearch: Bool
    var getMore: () -> Void

    var body: some View {
        let columns = [
            GridItem(.adaptive(minimum: size))
        ]
        
        ScrollView {
            LazyVGrid(columns: columns, spacing: spacing) {
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
            
            if (isSearch) {
                Button("More") {
                    getMore()
                }
                .padding()
                .overlay(
                    Capsule()
                        .stroke(.gray, lineWidth: 1)
                )
                .padding([.leading, .trailing, .top], 20)
            }
        }
    }
}
