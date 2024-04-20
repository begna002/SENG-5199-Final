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
                    product.title
                )
            )
        }
    }
}
