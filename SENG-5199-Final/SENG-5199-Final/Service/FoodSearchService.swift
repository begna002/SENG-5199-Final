//
//  FoodSearcService.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation

let baseUrl = "https://api.spoonacular.com/"
let commonParams = "&fillIngredients=true&addRecipeInformation=true&instructionsRequired=true&addRecipeNutrition=true"

func getIngrediantsByCusine(_ cuisine: String, completion: @escaping (FoodResponse?) -> Void){
    if (cuisine == "") {
        completion(nil)
        return
    }
    
    let url = URL(string: "\(baseUrl)/recipes/complexSearch/?cuisine=\(cuisine)&apiKey=19066718cb0143a080d795d5c3a5cd22\(commonParams)" )!
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print("Error fetching cuisine ingrediants: \(error)")
            completion(nil)
        }

        guard let responseData = data else {
            completion(nil)
            return
        }
        
        do {
            let foodResponse = try JSONDecoder().decode(FoodResponse.self, from: responseData)
            completion(foodResponse)
        } catch {
          print("Error decoding JSON data: \(error)")
        }
    }
    task.resume()
}
