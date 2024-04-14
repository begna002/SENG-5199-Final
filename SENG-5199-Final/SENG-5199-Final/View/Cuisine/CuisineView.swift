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

    var body: some View {
        VStack {
            NavigationSplitView {
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
                        
                        ForEach(CusineType.allCases, id: \.self) { key in
                            let foodResponse = cuisines[key.Name]
                            if let foodResponse {
                                CuisineRow(cusineName: key.Name, foodList: foodResponse)
                            }
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                    }
                    .navigationTitle("Featured")
                }
            } detail: {
                Text("Featured")
            }
        }
        .task {
            if (cuisines.isEmpty) {
                await fetchIngrediants()
                await fetchRandomIngrediants()
            }
        }
    }
    
    func fetchIngrediants() async {
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
    
    func fetchRandomIngrediants() async {
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
