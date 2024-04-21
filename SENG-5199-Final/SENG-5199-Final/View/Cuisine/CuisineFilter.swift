//
//  CuisineFilter.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/18/24.
//

import Foundation
import SwiftUI

struct CuisineFilter: View {
    @StateObject var filter = ViewModel.shared

    var body: some View {
        VStack {
//            Text("Filter")
//                .font(.subheadline)
            ScrollViewReader { value in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 12) {
                        ForEach(AllCusineType.allCases, id: \.id) { cuisine in
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
                            .id(cuisine)
                        }
                    }
                    .onChange(of: filter.filterIndex) {
                        withAnimation {
                            value.scrollTo(filter.filterIndex, anchor: .center)
                            filter.filterIndex = nil
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
        guard filter.cuisinesFilter[cuisine] != nil else {
            filter.fetching = true
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
    }
}
