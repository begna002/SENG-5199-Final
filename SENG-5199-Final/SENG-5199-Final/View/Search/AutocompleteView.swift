//
//  AutocompleteView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/22/24.
//

import Foundation
import SwiftUI

struct AutocompleteView: View {
    var autocompleteTerms: [AutocompleteResult] = []
    var userTerm: String
    var doSearch: (String) -> Void
    var closeView: () -> Void

    var body: some View {
        if (autocompleteTerms.count > 0) {
            Form {
                Section() {
                    List {
                        ForEach(autocompleteTerms) { term in
                            HStack {
                                Text(term.title)
                            }
                            .onTapGesture { doSearch(term.title) }
                        }
                        .listRowBackground(Color.clear)
                    }
                } header: {
                    HStack {
                        Text("Suggestions")
                        Spacer()
                        
                        HStack {
                            Text("Close").foregroundColor(.blue)
                        }.onTapGesture {
                            closeView()
                        }
                    }
                }

            }
                
        }
    }
    
 
}
