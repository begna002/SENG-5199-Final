//
//  CusineItem.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI

struct CuisineTabItem: View {
    var foodItem: FoodItem
    var width: CGFloat
    var height: CGFloat
    var scale: CGFloat = 2
    
    var body: some View {
        ZStack(alignment: .center) {
            AsyncImage(url: URL(string: foodItem.image),
                       scale: scale)
            .frame(width: .infinity, height: .infinity)
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
                .background(Color.clear)
            Text(foodItem.title)
                .font(.subheadline)
                .frame(width: 200, height: 25)
                .background(Capsule().fill(.white))
                .offset(y: -75)
        }
    }
}