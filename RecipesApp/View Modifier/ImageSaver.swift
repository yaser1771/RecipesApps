//
//  ImageSaver.swift
//  RecipesApp
//
//  Created by Mobile on 25/06/2023.
//
import Foundation
import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?

    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }

    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
    
//    func writeToDisk(image: UIImage, imageName: String) {
//            let savePath = FileManager.documentsDirectory.appendingPathComponent("\(imageName).jpg") //Where are I want to store my data
//            if let jpegData = image.jpegData(compressionQuality: 0.5) { // I can adjust the compression quality.
//                try? jpegData.write(to: savePath, options: [.atomic, .completeFileProtection])
//            }
//    }
}

// Used to save the image in the documents directory
//extension FileManager {
//    static var documentsDirectory: URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//}
