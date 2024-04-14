//
//  CuisinePlaceholderView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/14/24.
//

import Foundation
import SwiftUI

struct CusinePlaceholderView: View {
  var body: some View {
    List {
        HStack {
            Rectangle()
                .fill(.gray)
                .frame(height: 200)
                .cornerRadius(5)
        }
//        .frame(height: 200)
        .listRowBackground(Color.clear)
      ForEach (0..<5) { _ in
        HStack {
            PlaceholderRowView()
        }
        .redacted(reason: .placeholder)
      }
      .listRowInsets(EdgeInsets())
      .listRowBackground(Color.clear)
    }
    .navigationTitle("Featured")
  }
}

struct PlaceholderRowView: View {
  var body: some View {
      VStack(alignment: .leading) {
          Text("Placeholder")
              .font(.headline)
              .padding(.leading, 15)
              .padding(.top, 5)

          ScrollView(.horizontal, showsIndicators: false) {
              HStack(alignment: .top, spacing: 0) {
                  ForEach (0..<5) { _ in
                      PlaceholderItemView()
                  }
              }
          }
          .frame(height: 185)
      }
      .redacted(reason: .placeholder)
  }
}

struct PlaceholderItemView: View {
  var body: some View {
      VStack(alignment: .leading) {
          Rectangle()
              .fill(.gray)
              .frame(width: 140, height: 140)
              .cornerRadius(5)
          Text("Placeholder")
              .frame(width: 140)
                  .truncationMode(.tail)
              .font(.caption)
      }
      .padding(.leading, 15)
      .redacted(reason: .placeholder)
  }
}
