//
//  RecentSearchView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/21/24.
//

import Foundation
import SwiftUI
import SwiftData

struct RecentSearchView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var searchTerms: [RecentSearch]
    var doSearch: (String) -> Void
    @State var isConfirmDelete: Bool = false
    
    var body: some View {
        if (searchTerms.count > 0) {
            Form {
                Section() {
                    List {
                        ForEach(searchTerms) { term in
                            HStack {
                                Image(systemName: "clock.arrow.circlepath").padding(.trailing, 5)
                                Text(term.term)
                            }
                            .onTapGesture { doSearch(term.term) }
                        }
                        .listRowBackground(Color.clear)
                    }
                } header: {
                    HStack {
                        Text("Recent Searches")
                        Spacer()
                        
                        HStack {
                            if (isConfirmDelete) {
                                Text("Clear")
                                    .frame(width: 75, height: 20)
                                    .foregroundColor(.white)
                                    .background(Rectangle().fill(.red).stroke(.gray, lineWidth: 1))
                            } else {
                                Text("Clear").foregroundColor(.blue)

                            }
                        }.onTapGesture {
                            if (isConfirmDelete) {
                                isConfirmDelete = false
                                deleteAll()
                            } else {
                                isConfirmDelete = true
                            }
                        }
                    }
                }
            }
                
        }
    }
    
    func deleteAll() {
        do {
            try modelContext.delete(model: RecentSearch.self)
        } catch {
            print("Failed to clear all Recent Searches.")
        }
    }
}
