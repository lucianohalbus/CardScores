//Created by Halbus Development

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class StorageViewModel: ObservableObject {
    
    func saveMatchImage(userId: String?, item: UIImage, matchId: String) {
        guard let userId else { return }
        Task {
            let (path, name) = try await StorageManager.shared.saveUIImage(userId: userId, image: item)
            let url = try await StorageManager.shared.getUrlForImage(path: path)
            try await StorageManager.shared.updateUserImagePath(matchId: matchId, path: url.absoluteString)
        }
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
