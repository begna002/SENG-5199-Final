//
//  SearchView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SearchView: View {
    @State var text: String = ""
    @State var cuisines: [FoodItem]?
    @State var autocompleteTerms: [AutocompleteResult]?
    @State var fetching: Bool = false
    @State var offset: Int = 0
    @State var moreDisabled: Bool = false
    @State var error: ErrorType?
    @State var autoCompleteOpen: Bool = false
    
    @FocusState private var textFieldFocused: Bool

    @Environment(\.modelContext) private var modelContext
    @Query private var recentSearches: [RecentSearch]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                HStack {
                    TextField("Enter", text: $text) 
                        .padding()
                        .padding([.trailing], 40)
                        .overlay(
                            ZStack {
                                Capsule()
                                    .stroke(.gray, lineWidth: 1)
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        text = ""
                                        cuisines = nil
                                        error = nil
                                      }) {
                                          Image(systemName: "xmark.circle")
                                                                .frame(width: 40, height: 40)
                                    }
                                      .padding(.trailing, 10)
                                      .opacity(text.isEmpty ? 0 : 1)
                                      .disabled(text.isEmpty)
                                    
                                }
                            }
                        )
                        .padding([.leading, .trailing], 20)
                        .frame(height: 150)
                        .onSubmit {
                            submitSearch()
                        }
                        .onChange(of: text) {
                            if (!fetching) {
                                autoCompleteOpen = true
                                fetchAutocomplete(text)
                            }
                        }
                        .focused($textFieldFocused)
                }.frame(height: 50)
                
                if (fetching) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        LoadingIndicator()
                    }
                    .offset(y: 50)
                    .frame(maxWidth: .infinity)
                }
                
                Spacer()
                if (autoCompleteOpen) {
                    if let autocompleteTerms {
                        AutocompleteView(autocompleteTerms: autocompleteTerms, userTerm: text, doSearch: { term in
                            text = term
                            textFieldFocused = false
                            submitSearch()
                        }, closeView: {
                            autoCompleteOpen = false
                            textFieldFocused = false
                        })
                    }
                } else if let cuisines {
                    SearchResults(cuisines: cuisines, isSearch: true, getMore: {
                        fetchMore()
                    }, moreDisabled: moreDisabled)
                } else if let error {
                    CuisineError(error: error)
                    Spacer()
                    Spacer()
                } else if !fetching {
                    RecentSearchView(doSearch: { term in
                        text = term
                        submitSearch()
                    })
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .navigationTitle("Search")
        }
    }
    
    func submitSearch() {
        if (text != "") {
            autoCompleteOpen = false
            autocompleteTerms = nil
            cuisines = nil
            fetching = true
            error = nil
            moreDisabled = false
            getIngrediants(offset, text, completion: { response in
                fetching = false
                if let response {
                    if (!response.results.isEmpty) {
                        addRecentSearch(text)
                        if (response.results.count < 20) {
                            moreDisabled = true
                        }
                        cuisines = response.results
                    } else {
                        error = .NoResults
                    }
                } else {
                    error = .Exception
                }
            })
        }
    }
    
    func fetchAutocomplete(_ query: String) {
        if (text != "") {
            error = nil
            getAutocomplete(query, completion: { response in
                if let response {
                    if (!response.isEmpty) {
                        var termsThatStart: [AutocompleteResult] = []
                        var otherTerms: [AutocompleteResult] = []
                        for str in response {
                            let title: String = String(str.title.lowercased())
                            if (title.hasPrefix(text.lowercased())) {
                                termsThatStart.append(str)
                            } else {
                                otherTerms.append(str)
                            }
                        }
                    
                        autocompleteTerms = nil
                        autocompleteTerms = termsThatStart + otherTerms
                    } else {
                        error = .NoResults
                    }
                } else {
                    error = .Exception
                }
            })
        } else {
            cuisines = nil
            error = nil
            autoCompleteOpen = false
        }
    }
    
    func fetchMore() {
        offset += 20
        autocompleteTerms = nil
        autoCompleteOpen = false
        if (text != "") {
            getIngrediants(offset, text, completion: { response in
                fetching = false
                if let response {
                    if (!response.results.isEmpty) {
                        if (response.results.count < 20) {
                            moreDisabled = true
                        }
                        let savedCuisines = cuisines
                        cuisines = nil
                        if let savedCuisines {
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
    
    func addRecentSearch(_ termToSave: String) {
        for term in recentSearches {
            if (term.term == termToSave) {
                return
            }
        }
        
        let newTerm: RecentSearch = RecentSearch(termToSave)
        modelContext.insert(newTerm)
    }
}
