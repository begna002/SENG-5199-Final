//
//  SearchView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State var text: String = ""
    @State var cuisines: [FoodItem]?
    @State var fetching: Bool = false
    @State var offset: Int = 0

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Enter", text: $text)
                        .padding()
                        .overlay(
                            Capsule()
                                .stroke(.gray, lineWidth: 1)
                        )
                        .padding([.leading, .trailing], 20)
                        .frame(height: 150)
                        .onSubmit {
                            submitSearch()
                        }
                }.frame(height: 50)
                
                if (fetching) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        LoadingIndicator()
                    }
                    .offset(y: 50)
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
                if let cuisines {
                    SearchResults(cuisines: cuisines, isSearch: true, getMore: {
                        fetchMore()
                    })
                }
            }
            .navigationTitle("Search")
        }
    }
    
    func submitSearch() {
        if (text != "") {
            cuisines = nil
            fetching = true
            getIngrediants(offset, text, completion: { response in
                if let response {
                    if (!response.results.isEmpty) {
                        cuisines = response.results
                        fetching = false
                    }
                }
            })
        }
    }
    
    func fetchMore() {
        offset += 20
        if (text != "") {
            getIngrediants(offset, text, completion: { response in
                if let response {
                    if (!response.results.isEmpty) {
                        let savedCuisines = cuisines
                        cuisines = nil
                        if var savedCuisines {
                            let newList = savedCuisines + response.results
                            cuisines = newList
                        } else {
                            cuisines = response.results
                        }
                    }
                }
            })
        }
    }
}
