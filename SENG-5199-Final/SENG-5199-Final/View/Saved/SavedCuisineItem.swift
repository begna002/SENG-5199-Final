//
//  CusineItem.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI

struct SavedCuisineItem: View {
    var foodItem: FoodItemData

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: foodItem.image),
                              scale: 2)
                .frame(width: 140, height: 140)
                .cornerRadius(5)
            Text(foodItem.title)
                .frame(width: 140)
                    .truncationMode(.tail)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}
