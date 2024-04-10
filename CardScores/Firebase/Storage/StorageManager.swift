//Created by Halbus Development

import Foundation
import FirebaseStorage
import FirebaseFirestore
import FirebaseFirestoreSwift
import UIKit

final class StorageManager {
    static let shared = StorageManager()
    private init() {}
    
    private let storage = Storage.storage().reference()
    
    private func userReference(userId: String) -> StorageReference {
        storage.child("MatchPhotos").child(userId)
    }
    
    private let MatchCollection = Firestore.firestore().collection("scoresModel")
    
    func MatchDocument(matchId: String) -> DocumentReference {
        MatchCollection.document(matchId)
    }
    
    func getUrlForImage(path: String) async throws -> URL {
        try await Storage.storage().reference(withPath: path).downloadURL()
    }
    
    func getImages(userId: String, path: String) async throws -> Data {
        try await userReference(userId: userId).child(path).data(maxSize: 800 * 800)
    }
    
    func updateUserImagePath(matchId: String, path: String?, url: String?) async throws {
        let data: [String:Any] = [
            DBImages.CodingKeys.imagePath.rawValue : path ?? "",
            DBImages.CodingKeys.imagePathUrl.rawValue : url ?? "",
        ]
        
        try await MatchDocument(matchId: matchId).updateData(data)
    }

    func saveImage(userId: String, data: Data) async throws -> (path: String, name: String) {
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"
        
        let path = "\(UUID().uuidString).jpeg"
        let returnedMetaData = try await userReference(userId: userId).child(path).putDataAsync(data, metadata: meta)
        
        guard let returnedPath = returnedMetaData.path, let returnedName = returnedMetaData.name else {
            throw URLError(.badServerResponse)
        }
        
        return (returnedPath, returnedName)
    }
    
    func saveUIImage(userId: String, image: UIImage) async throws -> (path: String, name: String) {
        guard let data = image.jpegData(compressionQuality: 1) else {
            throw URLError(.badServerResponse)
        }
        
        return try await saveImage(userId: userId, data: data)
    }
    
    func deleteImage(path: String) async throws {
        try await getPathForImage(path: path).delete()
    }
    
    func getPathForImage(path: String) -> StorageReference {
        Storage.storage().reference(withPath: path)
    }
}
