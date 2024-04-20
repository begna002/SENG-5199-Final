//
//  CuisineView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation
import SwiftUI

struct CusineView: View {
    @State var cuisines: Dictionary<String, [FoodItem]> = [:]
    @State var cuisineTabResults: [FoodItem] = []
    @StateObject var filter = ViewModel.shared

    var body: some View {
        VStack {
            NavigationStack {
                if (cuisines.isEmpty) {
                    CusinePlaceholderView()
                } else {
                    List {
                        if cuisineTabResults.count > 0 {
                            HStack {
                                CusineTab(cuisines: cuisineTabResults)
                            }
                            .frame(height: 200)
                            .listRowBackground(Color.clear)
                        }
                        
                        CuisineFilter()
                        
                        if (filter.selectedCusine != "") {
                            if (filter.fetching) {
                                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                                    LoadingIndicator()
                                }
                                .frame(maxWidth: .infinity)
                                .listRowBackground(Color.clear)
                            } else {
                                let foodResponse = filter.cuisinesFilter[filter.selectedCusine]
                                if let foodResponse {
                                    SearchResults(cuisines: foodResponse, size: 150, spacing: 40, isSearch: false, getMore: {})
                                        .listRowBackground(Color.clear)
                                }
                            }
                        } else {
                            ForEach(CusineType.allCases, id: \.self) { key in
                                let foodResponse = cuisines[key.Name]
                                if let foodResponse {
                                    CuisineRow(cusineName: key.Name, foodList: foodResponse)
                                }
                            }
                            .listRowInsets(EdgeInsets())
                            .listRowBackground(Color.clear)
                        }
                    }
                    .navigationTitle("Featured")
                }
            } 
        }
        .task {
            if (cuisines.isEmpty) {
                fetchIngrediants()
                fetchRandomIngrediants()
            }
        }
    }
    
    func fetchIngrediants() {
        for cuisineType in CusineType.allCases {
            getIngrediantsByCusine(cuisineType.Name, completion: { response in
                
                if let response {
                    if (!response.results.isEmpty) {
                        cuisines[cuisineType.Name] = response.results

                    }
                }
            })
        }
    }
    
    func fetchRandomIngrediants() {
        getRandomIngrediants(completion: { response in
            if let response {
                if (!response.results.isEmpty) {
                    cuisineTabResults = response.results
                }
            }
        })
    }    
}


//#Preview {
//    CusineView()
//}
