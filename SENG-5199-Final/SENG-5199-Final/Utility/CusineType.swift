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
    
    var id: String { self.rawValue }
}
