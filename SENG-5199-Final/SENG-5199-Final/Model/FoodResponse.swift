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
    
    func hasNoDiet() -> Bool {
        return !(self.vegetarian || self.vegan || self.glutenFree || self.dairyFree)
    }
    
    func generateData() -> FoodItemData {
        //Generate NutrientInfoData
        var nutrients: [NutrientInfoData] = []
        for nutrient in self.nutrition.nutrients {
            nutrients.append(NutrientInfoData(nutrient.name, nutrient.amount, nutrient.unit, nutrient.percentOfDailyNeeds))
        }
        let nutrition = RecipeNutritionData(nutrients)
        
        //Generate RecipeInstructionsData
        var recipeInstructions: [RecipeInstructionsData] = []
        var recipeSteps: [RecipeStepData] = []
        for recipe in self.analyzedInstructions[0].steps {
            recipeSteps.append(RecipeStepData(recipe.number, recipe.step))
        }
        let recipeInstructionData = RecipeInstructionsData(recipeSteps)
        recipeInstructions.append(recipeInstructionData)
        
        //Generate RecipeIngredientData
        var recipeIngredients: [RecipeIngredientData] = []
        for ingredient in self.missedIngredients {
            recipeIngredients.append(RecipeIngredientData(ingredient.id, ingredient.image, ingredient.original, ingredient.originalName, ingredient.amount, ingredient.unitShort))
        }
        
        let foodItemData = FoodItemData(self.id, self.title, self.image, recipeIngredients, recipeInstructions, nutrition, self.vegetarian, self.vegan, self.glutenFree, self.dairyFree, self.readyInMinutes, self.preparationMinutes, self.cookingMinutes, self.servings)

        return foodItemData
    }
}

struct RecipeIngredient: Codable, Identifiable {
    var id: Int
    var image: String
    var original: String
    var originalName: String
    var amount: Float
    var unitShort: String
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
