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
    
}
