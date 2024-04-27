//
//  RecentSearches.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/21/24.
//

import Foundation
import SwiftData

@Model
final class RecentSearchModel: Identifiable {
    var term: String
    var id = UUID()

    init(_ term: String) {
        self.term = term
    }
}
