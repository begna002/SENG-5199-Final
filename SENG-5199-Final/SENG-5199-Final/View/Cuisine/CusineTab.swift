//
//  CuisineView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/5/24.
//

import Foundation
import SwiftUI

struct CusineTab: View {
    @State var cuisines:[FoodItem]
    @State private var currentIndex = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        TabView(selection: $currentIndex) {
          ForEach(0..<cuisines.count, id: \.self) { index in
              NavigationLink {
                  CusineDetail(foodItem: cuisines[index])
              } label: {
                  CuisineTabItem(foodItem: cuisines[index],  width: 400, height: 200, scale: 1)
              }
          }
          .listRowInsets(EdgeInsets())
          .listRowBackground(Color.clear)
        }
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .onReceive(timer, perform: { _ in
                        withAnimation {
                            currentIndex = currentIndex < cuisines.count ? currentIndex + 1 : 0
                        }
                    })
    }
}
