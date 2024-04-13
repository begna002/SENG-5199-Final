//
//  Item.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
