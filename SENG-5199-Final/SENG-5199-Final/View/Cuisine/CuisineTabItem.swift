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
                       scale: scale) {phase in
                    if let image = phase.image {
                        image
                    } else{
                        
                    }
                }
                .scaledToFill()
                .frame(height: 200)
                .clipped()
                .listRowInsets(EdgeInsets())
                .background(Color.clear)
            Text(foodItem.title)
                .font(.subheadline)
                .foregroundStyle(.black)
                .frame(width: 200, height: 25)
                .background(Rectangle().fill(.white).stroke(.gray, lineWidth: 1))
                .offset(y: -75)
        }
    }
}
