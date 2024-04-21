//
//  CusineType.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
// MAKE ENUM

enum CusineType: CaseIterable {
    case Italian
    case Asian
    case American
    case Indian
    case Mediterranean
    
    var Name : String {
        switch self {
        case .Italian:
            return "Italian"
        case .Asian:
            return "Asian"
        case .American:
            return "American"
        case .Indian:
            return "Indian"
        case .Mediterranean:
            return "Mediterranean"
        }
    }
}


enum AllCusineType: String, CaseIterable, Identifiable {
    case African = "African"
    case American = "American"
    case Asian = "Asian"
    case Chinese = "Chinese"
    case French = "French"
    case Greek = "Greek"
    case Indian = "Indian"
    case Italian = "Italian"
    case Japanese = "Japanese"
    case Mediterranean = "Mediterranean"
    case Mexican = "Mexican"
    
    func getIndex(cuisne: String) -> Int {
        switch(cuisne) {
        case "African":
            return 0
        case "American":
            return 1
        case "Asian":
            return 2
        case "Chinese":
            return 3
        case "French":
            return 4
        case "Greek":
            return 5
        case "Indian":
            return 6
        case "Italian":
            return 7
        case "Japanese":
            return 8
        case "Mediterranean":
            return 9
        case "Mexican":
            return 10
        default:
            return 0
        }
    }
    
    var id: String { self.rawValue }
}
