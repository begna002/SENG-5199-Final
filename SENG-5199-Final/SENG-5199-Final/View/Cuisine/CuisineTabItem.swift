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
    @State var image: UIImage?
    @State var imageFailed: Bool = false
    
    var body: some View {
        ZStack(alignment: .center) {
            if let image {
                Image(uiImage: image)
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                    .background(Color.clear)
                    .cornerRadius(5)
            } else if imageFailed {
                Image("foodDefault")
                    .scaledToFill()
                    .frame(height: 200)
                    .clipped()
                    .listRowInsets(EdgeInsets())
                    .background(Color.clear)
                    .cornerRadius(5)
            } else {
                PlaceholderTabView()
            }
            Text(foodItem.title)
                .font(.subheadline)
                .foregroundStyle(.black)
                .frame(width: 200, height: 25)
                .background(Rectangle().fill(.white).stroke(.gray, lineWidth: 1))
                .offset(y: -75)
        }
        .task {
            loadImageFromURL(urlString: foodItem.image, completion: { response in
                if let response {
                    image = response
                } else {
                    imageFailed = true
                }
            })
        }
    }
}
