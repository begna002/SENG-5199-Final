//
//  FoodDataModel.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/14/24.
//

import Foundation
import SwiftData

@Model
final class FoodItemData: Identifiable  {
    internal init(_ id: Int, _ title: String, _ image: String, _ missedIngredients: [RecipeIngredientData], _ analyzedInstructions: [RecipeInstructionsData], _ nutrition: RecipeNutritionData, _ vegetarian: Bool, _ vegan: Bool, _ glutenFree: Bool, _ dairyFree: Bool, _ readyInMinutes: Int, _ preparationMinutes: Int, _ cookingMinutes: Int, _ servings: Int) {
        self.id = id
        self.title = title
        self.image = image
        self.missedIngredients = missedIngredients
        self.analyzedInstructions = analyzedInstructions
        self.nutrition = nutrition
        self.vegetarian = vegetarian
        self.vegan = vegan
        self.glutenFree = glutenFree
        self.dairyFree = dairyFree
        self.readyInMinutes = readyInMinutes
        self.preparationMinutes = preparationMinutes
        self.cookingMinutes = cookingMinutes
        self.servings = servings
        self.images = []
    }
    
    var id: Int
    var title: String
    var image: String
    var missedIngredients: [RecipeIngredientData]
    var analyzedInstructions:  [RecipeInstructionsData]
    var nutrition: RecipeNutritionData
    var vegetarian: Bool
    var vegan: Bool
    var glutenFree: Bool
    var dairyFree: Bool
    var readyInMinutes: Int
    var preparationMinutes: Int
    var cookingMinutes: Int
    var servings: Int
    var images: [ImageData]
    
    func hasNoDiet() -> Bool {
        return !(self.vegetarian || self.vegan || self.glutenFree || self.dairyFree)
    }
}

@Model
final class ImageData: Identifiable {
    var id = UUID()
    var date: Date = Date()
    var image: Data
    
    internal init(_ image: Data) {
        self.image = image
    }
}

@Model
final class RecipeIngredientData: Identifiable {
    internal init(_ id: Int, _ image: String, _ original: String, _ originalName: String, _ amount: Float, _ unitShort: String) {
        self.id = id
        self.image = image
        self.original = original
        self.originalName = originalName
        self.amount = amount
        self.unitShort = unitShort
    }
    
    var id: Int
    var image: String
    var original: String
    var originalName: String
    var amount: Float
    var unitShort: String
}

@Model
final class RecipeInstructionsData {
    internal init(_ steps: [RecipeStepData]) {
        self.steps = steps.sorted(by: { $0.number < $1.number })
    }
    
    var steps: [RecipeStepData]
}

@Model
final class RecipeStepData {
    internal init(_ number: Int, _ step: String) {
        self.number = number
        self.step = step
    }
    
    var number: Int
    var step: String
}

@Model
final class RecipeNutritionData {
    internal init(_ nutrients: [NutrientInfoData]) {
        self.nutrients = nutrients
    }
    
    var nutrients: [NutrientInfoData]
}

@Model
final class NutrientInfoData {
    internal init(_ name: String, _ amount: Float, _ unit: String, _ percentOfDailyNeeds: Float) {
        self.name = name
        self.amount = amount
        self.unit = unit
        self.percentOfDailyNeeds = percentOfDailyNeeds
    }
    

    var name: String
    var amount: Float
    var unit: String
    var percentOfDailyNeeds: Float
}
