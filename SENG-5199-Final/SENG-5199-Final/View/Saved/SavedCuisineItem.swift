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
                              scale: 2) {phase in
                    if let image = phase.image {
                        image
                    } else{
                        
                    }
                }
                .frame(width: 140, height: 140)
                .cornerRadius(5)
            Text(foodItem.title)
                .frame(width: 140)
                    .truncationMode(.tail)
                .font(.caption)
                .foregroundStyle(.white)
        }
        .padding(.leading, 15)
    }
}
