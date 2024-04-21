//
//  CuisineRow.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation
import SwiftUI

struct CuisineRow: View {
    @StateObject var filter = ViewModel.shared
    var cusineName: String
    var foodList: [FoodItem]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(cusineName)
                    .font(.headline)
                    .padding(.leading, 15)
                    .padding(.top, 5)
                
                Spacer()

                    HStack {
                        Text("More").foregroundColor(.blue)
                        Image(systemName: "arrowshape.right.circle").foregroundColor(.blue)
                    }.onTapGesture { filterCuisine(cusineName) }

            }

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
    
    func filterCuisine(_ cuisine: String) {
        if (filter.selectedCusine == cuisine) {
            filter.selectedCusine = ""
        } else {
            filter.selectedCusine = cuisine
            fetchCuisine(cuisine)
        }
    }
    
    func fetchCuisine(_ cuisine: String) {
        guard filter.cuisinesFilter[cuisine] != nil else {
            filter.fetching = true
            filter.filterIndex = AllCusineType(rawValue: cuisine)!
            getIngrediantsByCusine(number: 30, cuisine, completion: { response in
                if let response {
                    if (!response.results.isEmpty) {
                        DispatchQueue.main.sync {
                            filter.cuisinesFilter[cuisine] = response.results
                            filter.fetching = false
                        }
                    }
                }
            })
            return
        }
        filter.filterIndex = AllCusineType(rawValue: cuisine)!
    }
}
