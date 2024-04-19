//
//  CuisineDetail.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI
import SwiftData

struct SavedCuisineDetail: View {
    var foodItem: FoodItemData
    @State var showIngrediants = true
    @State var showInstrucions = false
    @State var showDiet = true
    @State var showNutritionFacts = false
    
    @Environment(\.modelContext) private var modelContext

    @Query private var foodData: [FoodItemData]

    var body: some View {
        List {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Text(foodItem.title)
                    AsyncImage(url: URL(string: foodItem.image),
                               scale: 1)
                    .frame(width: 300, height: 250)
                    .cornerRadius(5)
                }
                .frame(maxWidth: .infinity)

                
                Spacer()
                HStack(spacing: 30) {
                    VStack(alignment: .center) {
                        Text("Total").bold()
                        HStack {
                            Image(systemName: "clock")
                            Text("\(foodItem.readyInMinutes) min")
                        }
                    }.font(Font.caption)
                    VStack(alignment: .center) {
                        let prepTime = foodItem.preparationMinutes == -1 ? "-" : "\(foodItem.preparationMinutes) min"
                        Text("Prep").bold()
                        HStack {
                            Image(systemName: "arrow.clockwise.circle")
                            Text("\(prepTime)")
                        }
                    }.font(Font.caption)
                    
                    VStack(alignment: .center) {
                        let calorieInfo = foodItem.nutrition.nutrients[0]
                        Text("Calories").bold()
                        HStack {
                            Text("\(Int(calorieInfo.amount)) \(calorieInfo.unit)")
                        }
                    }.font(Font.caption)
                    
                    VStack(alignment: .center) {
                        Text("Servings").bold()
                        HStack {
                            Image(systemName: "chart.pie")
                            Text("\(foodItem.servings)")
                        }
                    }.font(Font.caption)
                }
            }.listRowBackground(Color.clear)
            
            Section(
                header: SectionHeader(
                    title: "Nutrition Facts",
                    isOn: $showNutritionFacts
                )
            ){
                if showNutritionFacts {
                    let nutrients = foodItem.nutrition.nutrients
                    let nutrientSize: Int = nutrients.count
                    
                    ForEach(0..<nutrientSize) { index in
                        let nutrient = nutrients[index]
                        let nutrientAmountRounded = round(nutrient.amount, 3)
                        
                        HStack {
                            Text("\(nutrient.name)")
                            Spacer()
                            Text("\(nutrientAmountRounded) \(nutrient.unit)")
                        }
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    }
                }
            }
            
            
            Section(
                header: SectionHeader(
                    title: "Diet",
                    isOn: $showDiet
                )
            ){
                if showDiet {
                    if (foodItem.hasNoDiet()) {
                        HStack {
                            Text("No Dietary Restrictions")
                        }.listRowBackground(Color.clear)
                    } else {
                        HStack {
                            if foodItem.vegetarian { Text("Vegetarian")
                                    .font(.system(size: 9))
                                    .frame(width: 75, height: 25)
                                .background(Capsule().fill(.green)) }
                            if foodItem.vegan { Text("Vegan")
                                    .font(.system(size: 9))
                                    .frame(width: 75, height: 25)
                                .background(Capsule().fill(.green)) }
                            if foodItem.glutenFree { Text("Gluten Free")
                                    .font(.system(size: 9))
                                    .frame(width: 75, height: 25)
                                .background(Capsule().fill(.green)) }
                            if foodItem.dairyFree { Text("Dairy Free")
                                    .font(.system(size: 9))
                                    .frame(width: 75, height: 25)
                                .background(Capsule().fill(.green)) }
                        }.listRowBackground(Color.clear)
                    }
                }
            }
            
            Section(
                header: SectionHeader(
                    title: "Ingrediants",
                    isOn: $showIngrediants
                )
            ) {
                if showIngrediants {
                    ForEach(foodItem.missedIngredients) { ingrediant in
                        HStack {
                            AsyncImage(url: URL(string: ingrediant.image),
                                       scale: 2)
                            .frame(width: 50, height: 50)
                            .cornerRadius(1)
                            VStack(alignment: .leading) {
                                let ingrediantAmountRounded = round(ingrediant.amount, 2)
                                let ingrediantAmountTruncated = removeExtraZeros(ingrediantAmountRounded)

                                Text(ingrediant.originalName)
                                Text("\(ingrediantAmountTruncated) \(ingrediant.unitShort)")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
            }
            
            Section(
                header: SectionHeader(
                    title: "Instructions",
                    isOn: $showInstrucions
                )
            ) {
                if showInstrucions {
                    let instructions = foodItem.analyzedInstructions[0].steps
                    let numSteps: Int = instructions.count
                    
                    ForEach(0..<numSteps) { index in
                        let instructionStep = instructions[index]
                        HStack {
                            Text("\(instructionStep.number)")
                            Text(instructionStep.step)
                        }
                    }
                }
            }
        }.listSectionSpacing(0.5)
    }
    
    func round(_ num: Float, _ places: Int) -> String {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = places
        nf.maximumFractionDigits = places
        guard let number =  nf.string(from: NSNumber(value: num)) else { return "0" }
        return number
    }
    
    func removeExtraZeros(_ num: String) -> String {
        var numResult = num
        for number in numResult.reversed() {
            if (number == "0") {
                numResult.removeLast()
            } else if (number == ".") {
                numResult.removeLast()
                return numResult
            } else {
                return numResult
            }
        }
        
        return numResult
    }
    
    func deleteFood() {
        modelContext.delete(foodItem)
    }
}
