//
//  CuisineRow.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation
import SwiftUI

struct CuisineRow: View {
    var cusineName: String
    var foodList: [FoodItem]

    var body: some View {
        VStack(alignment: .leading) {
            Text(cusineName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 0) {
                    ForEach(foodList) { food in
                        NavigationLink {
                            CusineDetail(foodItem: food)
                        } label: {
                            CuisineItem(foodItem: food, width: 140, height: 140)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

//#Preview {
//    let landmarks = ModelData().landmarks
//    return CusineRow(
//        categoryName: landmarks[0].category.rawValue,
//        items: Array(landmarks.prefix(4))
//    )
//}
