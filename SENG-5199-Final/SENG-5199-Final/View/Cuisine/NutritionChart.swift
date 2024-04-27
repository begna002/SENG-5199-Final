//
//  NutritionChart.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/19/24.
//

import Foundation
import SwiftUI
import Charts

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let amount: Double
}

struct NutritionChart: View {
    @State var products: [Product]
    
    var body: some View {
        VStack {
            Text("Macro Calorie Ratio")
            Chart(products) { product in
                SectorMark(
                    angle: .value(
                        Text(verbatim: product.title),
                        product.amount
                    )
                )
                .foregroundStyle(
                    by: .value(
                        Text(verbatim: product.title),
                        "\(product.title): (\(round(Float(product.amount) * 100, 2))%)"
                    )
                )
            }
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
}
