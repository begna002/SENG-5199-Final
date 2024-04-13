//
//  SearchView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/13/24.
//

import Foundation
import SwiftUI

struct SearchView: View {
    @State var text: String = ""

    var body: some View {
        VStack {
            
            NavigationSplitView {
                VStack(alignment: .leading) {
                    TextField("Enter", text: $text)
                }
                .navigationTitle("Search")
            } detail: {
                Text("Search")
            }
        }
    }
}
