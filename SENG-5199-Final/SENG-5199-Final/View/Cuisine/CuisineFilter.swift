//
//  CuisineFilter.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/18/24.
//

import Foundation
import SwiftUI

class Filter: ObservableObject {
    static let shared = Filter()

    @Published var selectedCusine: String = ""
    @Published var cuisinesFilter: Dictionary<String, [FoodItem]> = [:]
    @Published var fetching: Bool = false

}

struct CuisineFilter: View {
    @StateObject var filter = Filter.shared

    var body: some View {
        VStack {
            Text("Filter")
                .font(.subheadline)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 12) {
                    ForEach(AllCusineType.allCases) { cuisine in
                        Button(action: {
                            filterCuisine(cuisine.rawValue)
                          }) {
                            Text(cuisine.rawValue)
                                .font(.subheadline)
                                .frame(width: 125, height: 25)
                                .background(Capsule()
                                    .fill(filter.selectedCusine == cuisine.rawValue ? .gray : .white)
                                    .stroke(.gray, lineWidth: 1))
                        }
                    }
                }
            }
        }
        
//        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
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
        guard let cuisineList = filter.cuisinesFilter[cuisine] else {
            filter.fetching = true
            getIngrediantsByCusine(number: 20, cuisine, completion: { response in
                if let response {
                    if (!response.results.isEmpty) {
                        filter.cuisinesFilter[cuisine] = response.results
                        filter.fetching = false
                    }
                }
            })
            return
        }
    }
}
