//
//  ImageService.swift
//  SENG-5199-Final
//
//  Created by Moti Begna on 4/22/24.
//

import Foundation
import SwiftUI

func loadImageFromURL(urlString: String, completion: @escaping (UIImage?) -> Void, _ retryCount: Int = 0) {
    let url = URL(string: urlString)
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    
    let session = URLSession.shared
    let task = session.dataTask(with: request) { data, response, error in
        if let error = error {
            print("Error fetching image: \(error)")
            completion(nil)
        }

        guard let responseData = data else {
            completion(nil)
            return
        }
        
        let image = UIImage(data: responseData)
        completion(image)


    }
    task.resume()
}

//    private func setImageCache(image: UIImage, key: String) {
//        imageCache?.setObject(image, forKey: key as NSString)
//    }
//
//    private func getImageFromCache(from key: String) -> UIImage? {
//        return imageCache?.object(forKey: key as NSString) as? UIImage
//    }
