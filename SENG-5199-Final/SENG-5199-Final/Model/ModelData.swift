//
//  ModelData.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation

@Observable
class ModelData {
    var cuisines: Dictionary<String, FoodResponse?> = [
        "Italian": getCuisine("Italian")
    ]
    
}

func getCuisine(_ cuisine: String) ->  FoodResponse? {
    do {
        try getIngrediantsByCusine("cuisine")
    } catch {
        
    }
}

