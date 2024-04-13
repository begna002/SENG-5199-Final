//
//  CusineItem.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI

struct CuisineItem: View {
    var foodItem: FoodItem

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: foodItem.image),
                              scale: 1)
                .frame(width: 155, height: 155)
                .cornerRadius(5)
            Text(foodItem.title)
                .frame(width: 155)
                    .truncationMode(.tail)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}
