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

    var body: some View {
        VStack {
            NavigationSplitView {
                List {
                    ForEach(CusineType.allCases, id: \.self) { key in
                        let foodResponse = cuisines[key.Name]
                        if let foodResponse {
                            CuisineRow(cusineName: key.Name, foodList: foodResponse)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .navigationTitle("Featured")
            } detail: {
                Text("Featured")
                }
        } .task {
            // Make this async
            if (cuisines.isEmpty) {
                await fetchIngrediants()
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

}


//#Preview {
//    CusineView()
//}
