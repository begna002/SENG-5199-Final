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
    var width: CGFloat
    var height: CGFloat
    var scale: CGFloat = 2
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: foodItem.image),
                              scale: scale)
                .frame(width: width, height: height)
                .cornerRadius(5)
            Text(foodItem.title)
                .frame(width: 140)
                    .truncationMode(.tail)
                .font(.caption)
        }
        .padding(.leading, 15)
    }
}
