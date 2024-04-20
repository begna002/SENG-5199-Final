//
//  FilterViewModel.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/19/24.
//

import Foundation

class ViewModel: ObservableObject {
    static let shared = ViewModel()

    @Published var selectedCusine: String = ""
    @Published var cuisinesFilter: Dictionary<String, [FoodItem]> = [:]
    @Published var fetching: Bool = false
    @Published var currentGallery: [Data] = []
}
