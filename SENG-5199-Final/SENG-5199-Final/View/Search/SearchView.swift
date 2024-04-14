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

    var body: some View {
        NavigationSplitView {
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
                            fetching = true
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
                    SearchResults(cuisines: cuisines)
                }
            }
            .navigationTitle("Search")
        } detail: {
            Text("Search")
        }
    }
    
    func submitSearch() {
        cuisines = nil
        if (text != "") {
            getIngrediants(text, completion: { response in
                if let response {
                    if (!response.results.isEmpty) {
                        cuisines = response.results
                        fetching = false
                    }
                }
            })
        }
    }
}
