//
//  PhotoAccessView.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/20/24.
//

import Foundation
import SwiftUI
import PhotosUI

struct accessCameraView: UIViewControllerRepresentable {

    var foodItem: FoodItemData
    @Binding var selectedImages: [ImageData]?

    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView

    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        let imageData = selectedImage.jpegData(compressionQuality: 1.0)!
        let imageDataClass = ImageData(imageData)

        let selectedImages = self.picker.selectedImages
        self.picker.selectedImages = nil
        if var selectedImages {
            let newList = selectedImages + [imageDataClass]
            self.picker.selectedImages = newList
        } else {
            self.picker.selectedImages = [imageDataClass]
        }
        
        self.picker.foodItem.images.append(imageDataClass)
        
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
