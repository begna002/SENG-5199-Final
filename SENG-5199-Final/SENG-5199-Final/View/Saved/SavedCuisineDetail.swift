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
    @State var showIngrediants = true
    @State var showInstrucions = false
    @State var showDiet = true
    @State var showNutritionFacts = false
    @State var showGallery = true
    @State var showDeleteAlert = false
    @State var calorieAmount: Float = 0.0
    @State var image: UIImage?
    @State var imageFailed: Bool = false
    
    @StateObject var filter = ViewModel.shared
    @StateObject var navigation = NavigationViewModel.shared

    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode

    @Query private var foodData: [FoodItemData]
    
    var foodItem: FoodItemData
    var completion: (FoodItemData) -> Void

    
    var body: some View {
        List {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                    Text(foodItem.title)
                    if let image {
                        Image(uiImage: image)
                            .frame(width: 300, height: 250)
                            .cornerRadius(5)
                    } else if imageFailed {
                        Image("foodDefault")
                            .scaleEffect(0.5)
                            .frame(width: 300, height: 250)
                            .cornerRadius(5)
                    } else {
                        PlaceholderItemView()
                    }
                    
                    Button(action: {
                        showDeleteAlert = true
                      }) {
                        Text("Delete Recipe")
                            .font(.subheadline)
                            .frame(width: 125, height: 25)
                            .background(Capsule()
                                .fill(.white)
                                .stroke(.gray, lineWidth: 1))
                            .padding()
                            .padding([.leading, .trailing], 20)
                    }
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
                        if foodItem.nutrition != nil {
                            Text("Calories").bold()
                            HStack {
                                Image(systemName: "flame")
                                Text("\(Int(calorieAmount)) kcal")
                            }
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
                    if let nutrition = foodItem.nutrition{
                        var nutrients = nutrition.nutrients
                        let products = getNutritionProducts(nutrients)
                        let _ = nutrients.sort {
                            $0.number < $1.number
                        }
                        
                        HStack {
                            NutritionChart(products: products)
                        }
                        
                        ForEach(nutrients) { nutrient in
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
                    var instructions = foodItem.analyzedInstructions[0].steps
                    
                    let _ = instructions.sort {
                        $0.number < $1.number
                    }
                    
                    ForEach(instructions) { instructionStep in
                        HStack {
                            Text("\(instructionStep.number)").padding(.trailing, 10)
                            Text(instructionStep.step)
                        }
                    }
                }
            }
            
            Section(
                header: SectionHeader(
                    title: "Gallery",
                    isOn: $showGallery
                )
            ) {
                if showGallery {
                    PhotoView(foodItem: foodItem)
                        .listRowBackground(Color.clear)
                }
            }
            
        }
        .listSectionSpacing(0.5)
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Delete?"),
                  primaryButton: Alert.Button.default(Text("Delete"), action: {
                    showDeleteAlert = false
                    self.presentationMode.wrappedValue.dismiss()
                    completion(foodItem)
                  }),
                  secondaryButton: Alert.Button.cancel(Text("Cancel"), action: {
                    showDeleteAlert = false
                  })
            )
        }
        .onChange(of: navigation.navToHome) {
            self.presentationMode.wrappedValue.dismiss()
        }
        .task {
            if let nutrition = foodItem.nutrition{
                for nutrient in nutrition.nutrients {
                    if (nutrient.name == "Calories") {
                        calorieAmount = nutrient.amount
                    }
                }
            }
            
            loadImageFromURL(urlString: foodItem.image, completion: { response in
                if let response {
                    image = response
                } else {
                    imageFailed = true
                }
            })
        }
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
    
    func getNutritionProducts(_ nutrients: [NutrientInfoData]) -> [Product] {
        var nutritionList: [Product] = []
        
        var proteinAmount: Double = 0.0
        var fatAmount: Double = 0.0
        var carbAmount: Double = 0.0

        for nutrient in nutrients {
            if (nutrient.name == "Protein") {
                proteinAmount = Double(nutrient.amount * 4)
            }
            if (nutrient.name == "Fat") {
                fatAmount = Double(nutrient.amount * 9)
            }
            if (nutrient.name == "Carbohydrates") {
                carbAmount = Double(nutrient.amount * 4)
            }
        }
        
        let totalAmmount = proteinAmount + fatAmount + carbAmount
        nutritionList.append(Product(title: "Protein", amount: proteinAmount/totalAmmount))
        nutritionList.append(Product(title: "Fat", amount: fatAmount/totalAmmount))
        nutritionList.append(Product(title: "Carbohydrates", amount: carbAmount/totalAmmount))
        
        return nutritionList
    }
}
