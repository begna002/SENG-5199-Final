//
//  FilterViewModel.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/19/24.
//

import Foundation

class FilterViewModel: ObservableObject {
    static let shared = FilterViewModel()

    @Published var selectedCusine: String = ""
    @Published var cuisinesFilter: Dictionary<String, [FoodItem]> = [:]
    @Published var fetching: Bool = false
}
