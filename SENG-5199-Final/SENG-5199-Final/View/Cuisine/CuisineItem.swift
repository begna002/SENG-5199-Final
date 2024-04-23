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
    @State var image: UIImage?
    
    @State var imageFailed: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            if let image {
                Image(uiImage: image)
                    .frame(width: width, height: height)
                    .cornerRadius(5)
            } else if imageFailed {
                Image("foodDefault")
                    .scaleEffect(0.5)
                    .frame(width: width, height: height)
                    .cornerRadius(5)
            } else {
                PlaceholderItemView()
            }
            Text(foodItem.title)
                .frame(width: 140)
                    .truncationMode(.tail)
                .font(.caption)
                .foregroundStyle(.white)
        }
        .padding(.leading, 15)
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
