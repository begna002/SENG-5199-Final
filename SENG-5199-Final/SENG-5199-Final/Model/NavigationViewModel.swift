//
//  NavigationViewModel.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/27/24.
//

import Foundation

@MainActor class NavigationViewModel: ObservableObject {
    static let shared = NavigationViewModel()

    @Published var navToHome: Bool = false
    @Published var tabSelection: Tab = .explore
}
