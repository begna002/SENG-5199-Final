//
//  CuisineDetail.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI

struct CusineDetail: View {
    var foodItem: FoodItem
    @State var showIngrediants = true
    @State var showInstrucions = false
    
    var body: some View {
        List {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                AsyncImage(url: URL(string: foodItem.image),
                           scale: 1)
                .frame(width: 300, height: 250)
                .cornerRadius(5)
                Text(foodItem.title)
                
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
                    title: "Ingrediants",
                    isOn: $showIngrediants
                )
            ) {
                if showIngrediants {
                    ForEach(foodItem.missedIngredients) { ingrediant in
                        HStack {
                            Text(ingrediant.original)
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
        }.listSectionSpacing(1)
    }
}
