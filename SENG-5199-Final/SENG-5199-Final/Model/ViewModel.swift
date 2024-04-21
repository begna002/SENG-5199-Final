//
//  FilterViewModel.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/19/24.
//

import Foundation

@MainActor class ViewModel: ObservableObject {
    static let shared = ViewModel()

    @Published var selectedCusine: String = ""
    @Published var cuisinesFilter: Dictionary<String, [FoodItem]> = [:]
    @Published var fetching: Bool = false
    @Published var filterIndex: AllCusineType? = .African
    
    @Published var navToHome: Bool = false
    @Published var tabSelection: Tab = .explore

}
