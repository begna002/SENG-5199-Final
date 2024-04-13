//
//  FoodResponse.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation

struct FoodResponse: Codable  {
    var results: [FoodItem]
}

struct FoodItem: Codable, Identifiable  {
    var id: Int
    var title: String
    var image: String
    var missedIngredients: [RecipeIngredient]
    var analyzedInstructions:  [RecipeInstructions]
    var nutrition: RecipeNutrition
    var vegetarian: Bool
    var vegan: Bool
    var glutenFree: Bool
    var dairyFree: Bool
    var readyInMinutes: Int
    var preparationMinutes: Int
    var cookingMinutes: Int
    var servings: Int
}

struct RecipeIngredient: Codable, Identifiable {
    var id: Int
    var image: String
    var original: String
}

struct RecipeInstructions: Codable {
    var steps: [RecipeStep]
}

struct RecipeStep: Codable {
    var number: Int
    var step: String
}

struct RecipeNutrition: Codable {
    var nutrients: [NutrientInfo]
}

struct NutrientInfo: Codable {
    var name: String
    var amount: Float
    var unit: String
    var percentOfDailyNeeds: Float
}
