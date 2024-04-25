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
    @State var showDeleteAlert = false
    var completion: () -> Void

    var body: some View {
        VStack {
            Text("Taken: \(dateString)")
            Image(uiImage: image)
                               .resizable()
                               .scaledToFit()
            Button(action: {
                showDeleteAlert = true
              }) {
                Text("Delete Image")
                    .font(.subheadline)
                    .frame(width: 125, height: 25)
                    .background(Capsule()
                        .fill(.white)
                        .stroke(.gray, lineWidth: 1))
                    .padding()
                    .padding([.leading, .trailing], 20)
            }
        }
        .task {
            dateString = dateFormatter(imageData.date)
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(title: Text("Delete?"),
                  primaryButton: Alert.Button.default(Text("Delete"), action: {
                    showDeleteAlert = false
                    completion()
                  }),
                  secondaryButton: Alert.Button.cancel(Text("Cancel"), action: {
                    showDeleteAlert = false
                  })
            )
        }
    
    }
    
    func dateFormatter(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
            
      
    }
}
