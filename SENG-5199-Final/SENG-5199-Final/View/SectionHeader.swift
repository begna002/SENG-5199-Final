//
//  SectionHeader.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI

struct SectionHeader: View {
  
  @State var title: String
  @Binding var isOn: Bool
  
  var body: some View {
      VStack {
          Divider()
          Spacer()
          Button(action: {
            withAnimation {
              isOn.toggle()
            }
          }, label: {
            if isOn {
                Image(systemName: "chevron.up.circle")
            } else {
                Image(systemName: "chevron.down.circle")
            }
          })
          .foregroundColor(.accentColor)
          .frame(maxWidth: .infinity, alignment: .trailing)
          .overlay(
            Text(title),
            alignment: .leading
          )
      }
  }
}
