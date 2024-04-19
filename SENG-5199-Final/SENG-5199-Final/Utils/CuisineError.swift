//
//  CuisineError.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/19/24.
//

import Foundation
import SwiftUI

enum ErrorType: String, CaseIterable, Identifiable {
    case Exception = "Error returned when fetching results"
    case NoResults = "No Results Found"
    
    var id: String { self.rawValue }
}


struct CuisineError: View {
    var error: ErrorType
    var body: some View {
        HStack(alignment: .center) {
            Text(error.rawValue)
        }
        .frame(maxWidth: .infinity)

    }
}
