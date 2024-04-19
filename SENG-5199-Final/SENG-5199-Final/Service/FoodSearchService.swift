//
//  FoodSearcService.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation

let baseUrl = "https://api.spoonacular.com/"
let commonParams = "&fillIngredients=true&addRecipeInformation=true&instructionsRequired=true&addRecipeNutrition=true"

func getIngrediants(_ offset: Int, _ query: String, completion: @escaping (FoodResponse?) -> Void){
    if (query == "") {
        completion(nil)
        return
    }
    
    let url = URL(string: "\(baseUrl)/recipes/complexSearch/?query=\(query)&number=20&offset=\(offset)&apiKey=19066718cb0143a080d795d5c3a5cd22\(commonParams)" )!
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
            print("Error decoding JSON data: \(error), url: \(url)")
            completion(nil)
        }
    }
    task.resume()
}

func getIngrediantsByCusine(number: Int = 10, _ cuisine: String, completion: @escaping (FoodResponse?) -> Void){
    if (cuisine == "") {
        completion(nil)
        return
    }
    
    let url = URL(string: "\(baseUrl)/recipes/complexSearch/?cuisine=\(cuisine)&number=\(number)&apiKey=19066718cb0143a080d795d5c3a5cd22\(commonParams)" )!
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
            print("Error decoding JSON data: \(error), url: \(url)")
            completion(nil)
        }
    }
    task.resume()
}

func getRandomIngrediants(completion: @escaping (FoodResponse?) -> Void){
    let query = foodSearches.randomElement() ?? "Pizza"
    let url = URL(string: "\(baseUrl)/recipes/complexSearch?query=\(query)&number=10&apiKey=19066718cb0143a080d795d5c3a5cd22\(commonParams)" )!
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
          print("Error decoding JSON data: \(error), url: \(url)")
          completion(nil)
        }
    }
    task.resume()
}

let foodSearches = [
    "Pizza",
    "Sushi",
    "Burger",
    "Taco",
    "Pasta",
    "Salad",
    "Soup",
    "Sandwich",
    "Steak",
    "Curry",
    "Noodles",
    "Ramen",
    "Bagel",
    "Donut",
    "Cake",
    "Cookie",
    "Fruit",
    "Vegetable",
    "Smoothie",
    "Omelette",
    "Bread",
    "Pancake",
    "Waffle",
    "Cheese",
    "Rice",
    "Pork",
    "Beef",
    "Chicken",
    "Shrimp",
    "Salmon",
    "Tuna",
    "Sausage",
    "Bacon",
    "Egg",
    "Avocado",
    "Tomato",
    "Potato",
    "Onion",
    "Garlic",
    "Spinach",
    "Mushroom",
    "Lettuce",
    "Cucumber",
    "Carrot",
    "Broccoli",
    "Zucchini",
    "Celery",
    "Banana",
    "Apple"
]
