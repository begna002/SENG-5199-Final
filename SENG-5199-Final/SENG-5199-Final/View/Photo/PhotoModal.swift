//
//  PhotoModal.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/20/24.
//

import Foundation
import SwiftUI

struct PhotoModal: View {
    var image: UIImage
    var imageData: ImageData
    @State var dateString: String = ""

    var body: some View {
        VStack {
            Text("Taken: \(dateString)")
            Image(uiImage: image)
                               .resizable()
                               .scaledToFit()
        }
        .task {
            dateString = dateFormatter(imageData.date)
            print(imageData.date)

        }
    
    }
    
    func dateFormatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
            
      
    }
}
