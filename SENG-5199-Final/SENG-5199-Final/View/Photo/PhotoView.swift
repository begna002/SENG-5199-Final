//
//  PhotoView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/20/24.
//

import SwiftUI
import PhotosUI

struct PhotoView: View {
    @State private var showCamera = false
    @State var foodItem: FoodItemData
    @State var selectedImages: [ImageData]?
    @State var isShowingSheet: Bool = false

    var body: some View {
        VStack {
            if let selectedImages{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 20) {
                        ForEach(selectedImages) { image in
                            let uiImage: UIImage? = UIImage(data: image.image)
                            
                            if let uiImage {
                                Button(action: {
                                    isShowingSheet = true
                                }) {
                                    Image(uiImage: uiImage)
                                                            .resizable()
                                                            .scaledToFit()
                                }.sheet(isPresented: $isShowingSheet,
                                        onDismiss: { isShowingSheet = false } ) {
                                    PhotoModal(image: uiImage, imageData: image)
                                     
                                 }
                            }
                        }
                    }
                    .frame(height: foodItem.images.count > 0 ? 185 : 0)
                    .padding(.bottom, 40)
                }
           }
        
            HStack {
                Button(action:{
                    self.showCamera.toggle()
                }) {
                    Text("Take Photo")
                        .font(.subheadline)
                        .frame(width: 125, height: 25)
                        .background(Capsule()
                            .fill(.white)
                            .stroke(.gray, lineWidth: 1))
                }
                .fullScreenCover(isPresented: self.$showCamera) {
                    accessCameraView(foodItem: self.foodItem, selectedImages: self.$selectedImages)

                }
            }
        }
        .task {
            selectedImages = foodItem.images
        }
    }
}
